require 'pry'
require 'faraday'
# require 'octokit'

# allow us to peek at http traffic
# debug_http = false
# if debug_http
#   stack = Faraday::RackBuilder.new do |builder|
#     builder.use Faraday::Request::Retry, exceptions: [Octokit::ServerError]
#     builder.use Octokit::Middleware::FollowRedirects
#     builder.use Octokit::Response::RaiseError
#     builder.use Octokit::Response::FeedParser
#     builder.response :logger
#     builder.adapter Faraday.default_adapter
#   end
#   Octokit.middleware = stack
# end
# iandouglas
personal_access_token = '23288a899b47f7142ee35fd21859b5b3bf76a6a2'
# client = Octokit::Client.new(:access_token => personal_access_token)
@conn = Faraday.new(url: "https://api.github.com") do |f|
  f.adapter  Faraday.default_adapter
  f.headers["Accept"] = "application/vnd.github.inertia-preview+json"
  f.headers["Authorization"] = "token #{personal_access_token}"
  f.headers["Content-Type"] = "application/json"
end

backoff = 0

def get_json(url)
  response = @conn.get(url)
  while response.headers['x-retry-after']
    sleep(response.headers['x-retry-after'])
    response = @conn.get(url)
    binding.pry
  end
  JSON.parse(response.body, symbolize_names: true)
end

def post_json(url, body)
  response = @conn.post(url, body)
  while response.headers['x-retry-after']
    sleep(response.headers['x-retry-after'])
    response = @conn.post(url, body)
    binding.pry
  end
  JSON.parse(response.body, symbolize_names: true)
end

def create_issue(owner_repo, options = {})
  url = "/repos/#{owner_repo}/issues"
  body = {
    title: options[:title],
    body: options[:body],
    labels: options[:labels]
  }
  resp = post_json(url, body.to_json)
  binding.pry
end


repos = [
  'iandouglas/github-scraper'.freeze,
  'turingschool-projects/apollo_14'.freeze,
]

repos.each do |repo|
  create_issue(repo, title: 'plan C')
  # issues = client.issues(repo)
  # repo_obj = client.repository(repo)
  #  client.create_issue(repo, 'issue with repo string')
  # client.create_issue(repo_obj.id, 'issue with repo obj.id')
  # puts repo_obj.id
  # puts "api calls remaining until reset: #{client.rate_limit.remaining}"
#  issues.each do |issue|
#    if issue.title == 'book_club'
#      puts '---'
#      puts issue.inspect
#      puts '==='
#      core_number = issue.number
#      client.update_issue(repo, core_number, "#{issue.title} -- in progress", '', labels:['in progress'])
#    end
#  end
end

=begin

  issues = repo.

  app.on('issues.opened', async context => {
    // app.log("i have new issues");
    const issueTitle = context.payload.issue.title
    // app.log(issueTitle);

    const triggerPattern = /^bootstrap ([a-zA-Z0-9-_])/gi;
    var newIssues = [];
    if (triggerPattern.test(issueTitle)) {
      var project = issueTitle.replace(triggerPattern, '$1');

      app.log('bootstrap running for project '+project+'...')

      //move bootstrap issue into progress
      const updateIssue = context.repo({
        number: context.payload.issue.number,
        title: 'bootstrap '+project+' in progress',
        labels: ['in progress']
      })
      context.github.issues.edit(updateIssue)

      //get card data from config
      const cardData = await getCardData(project)
      app.log("card data:");
      app.log(cardData);

//       //create cards in reverse order for proper order on waffle.io board
      const newIssues = await createCards(project, context, cardData.reverse())
      app.log("issues created:");
      app.log(newIssues);

//       //update cards with epic and dependency relationships
      await updateCardRelationships(context, cardData, newIssues)

      //close bootstrap issue
      const closeIssue = context.repo({
        number: context.payload.issue.number,
        state: 'closed'
      })
      context.github.issues.edit(closeIssue)
    }
  })
}

async function getCardData(project) {
  const cardsData = await helpers.readFilePromise('./_output/'+project+'/cards.json')
  const cardsJSON = JSON.parse(cardsData)
  return cardsJSON
}

async function createCards(project, context, cardData) {
  let newIssues = []

  for (const card of cardData) {
    const response = await (createIssue(project, context, card))
    newIssues.push({id: card.id, issueNumber: response.data.number})
  }

  return newIssues;
}

async function updateCardRelationships(context, cardData, newIssues) {

  for (const card of cardData) {
    console.log('updaterelationship, card.id: ' + card.id)
    const newIssue = newIssues.find(issue => issue.id === card.id)
    console.log('card.id: ' + card.id + ' was given issue.id: ' + newIssue.issueNumber)

    if(card.childOf) {
      console.log('card.id: ' + card.id + ' reports to be a child of card.id ' + card.childOf);
      const parentIssue = newIssues.find(issue => issue.id === card.childOf)
      console.log('card.id: ' + card.id + ' has parent card.id: ' + card.childOf + ' whose issue.id is ' + parentIssue.issueNumber)
      let issue = await getIssue(context, newIssue.issueNumber)
      const newBody = issue.data.body + '\n\nchild of #' + parentIssue.issueNumber
      await editIssue(context, newIssue.issueNumber, newBody)
      await sleep(1250);
    }

    if(card.dependsOn) {
      for (const dependencyId of card.dependsOn) {
        const dependencyIssue = newIssues.find(issue => issue.id === dependencyId)
        console.log('card.id: ' + card.id + ' has dependency on card.id: ' + dependencyId + ' whose issue.id is ' + dependencyIssue.issueNumber)
        let issue = await getIssue(context, newIssue.issueNumber)
        const newBody = issue.data.body + '\n\ndepends on #' + dependencyIssue.issueNumber
        await editIssue(context, newIssue.issueNumber, newBody)
        await sleep(1250);
      }
    }
  }
}

async function getIssue(context, issueNumber) {

  const issue = context.repo({
    number: issueNumber
  })
  const response = await context.github.issues.get(issue)
  return response
  console.log(response)
}

async function createIssue(project, context, cardData) {
  const cardContentData = await helpers.readFilePromise('./_output/'+project+'/cards/' + cardData.id + '.md')

  const newIssue = context.repo({
    title: cardData.title,
    labels: cardData.labels,
    body: cardContentData
  })
  const response = await context.github.issues.create(newIssue)
  await sleep(5000);
  return response
}

async function editIssue(context, issueNumber, body) {

  const newIssue = context.repo({
    number: issueNumber,
    body: body
  })
  const response = await context.github.issues.edit(newIssue)
  await sleep(500);
  return response
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}




=end
