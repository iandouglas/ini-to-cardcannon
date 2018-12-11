require 'octokit'
require 'json'

# allow us to peek at http traffic
debug_http = false
if debug_http
  stack = Faraday::RackBuilder.new do |builder|
    builder.use Faraday::Request::Retry, exceptions: [Octokit::ServerError]
    builder.use Octokit::Middleware::FollowRedirects
    builder.use Octokit::Response::RaiseError
    builder.use Octokit::Response::FeedParser
    builder.response :logger
    builder.adapter Faraday.default_adapter
  end
  Octokit.middleware = stack
end
# iandouglas
personal_access_token = '23288a899b47f7142ee35fd21859b5b3bf76a6a2'
@client = Octokit::Client.new(:access_token => personal_access_token)

user = client.user
puts "logged in as #{user.login}"

project = ARGV[0]
repo = ARGV[1]
unless project and repo
  puts "Usage: slam.rb project_name user/repo"
  exit
end
if Dir[repo] == nil
  puts "Project name provided seems invalid"
  exit
end
unless File.directory?("./_output/#{project}") && File.file?("./_output/#{project}/cards.json")
  puts "Project name provided doesn't seem ready in _output folder"
  exit
end

@card_tracker = []

def create_cards(repo, card_data) {
  card_data.each do |card|
    issue = @client.create_issue(repo, "User Story #{}, #{}")
    @card_tracker << {
      issue_number: issue.number,
      story_id: card[:id]
    }
  }
}

# issue = client.create_issue(repo, 'test from ian, please ignore!!')
# puts issue.number
# puts issue.inspect
=begin
{
  :url=>"https://api.github.com/repos/iandouglas/github-scraper/issues/784", 
  :repository_url=>"https://api.github.com/repos/iandouglas/github-scraper", 
  :labels_url=>"https://api.github.com/repos/iandouglas/github-scraper/issues/784/labels{/name}", 
  :comments_url=>"https://api.github.com/repos/iandouglas/github-scraper/issues/784/comments", 
  :events_url=>"https://api.github.com/repos/iandouglas/github-scraper/issues/784/events", 
  :html_url=>"https://github.com/iandouglas/github-scraper/issues/784", 
  :id=>389452810, 
  :node_id=>"MDU6SXNzdWUzODk0NTI4MTA=", 
  :number=>784, 
  :title=>"test from ian, please ignore!!", 
  :user=>{:login=>"iandouglas", :id=>168030, :node_id=>"MDQ6VXNlcjE2ODAzMA==", :avatar_url=>"https://avatars0.githubusercontent.com/u/168030?v=4", :gravatar_id=>"", :url=>"https://api.github.com/users/iandouglas", :html_url=>"https://github.com/iandouglas", :followers_url=>"https://api.github.com/users/iandouglas/followers", :following_url=>"https://api.github.com/users/iandouglas/following{/other_user}", :gists_url=>"https://api.github.com/users/iandouglas/gists{/gist_id}", :starred_url=>"https://api.github.com/users/iandouglas/starred{/owner}{/repo}", :subscriptions_url=>"https://api.github.com/users/iandouglas/subscriptions", :organizations_url=>"https://api.github.com/users/iandouglas/orgs", :repos_url=>"https://api.github.com/users/iandouglas/repos", :events_url=>"https://api.github.com/users/iandouglas/events{/privacy}", :received_events_url=>"https://api.github.com/users/iandouglas/received_events", :type=>"User", :site_admin=>false}, 
  :labels=>[], 
  :state=>"open", 
  :locked=>false, 
  :assignee=>nil, 
  :assignees=>[], 
  :milestone=>nil, 
  :comments=>0, 
  :created_at=>2018-12-10 19:32:15 UTC, 
  :updated_at=>2018-12-10 19:32:15 UTC, 
  :closed_at=>nil, 
  :author_association=>"OWNER", 
  :body=>nil, 
  :closed_by=>nil
}
=end
puts "api calls remaining until reset: #{@client.rate_limit.remaining}"
#      client.update_issue(repo, core_number, "#{issue.title} -- in progress", '', labels:['in progress'])

file = File.read("./_output/#{project}/cards.json")
cards = JSON.parse(file)

create_cards(repo, cards.reverse)
puts cards
=begin

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
