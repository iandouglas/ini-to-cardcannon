require 'octokit'
require 'json'
require 'pry'

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

user = @client.user
puts "logged in as #{user.login}"

@project = ARGV[0]
repo = ARGV[1]
unless @project and repo
  puts "Usage: slam.rb project_name user/repo"
  exit
end
if Dir[repo] == nil
  puts "Project name provided seems invalid"
  exit
end
unless File.directory?("./_output/#{@project}") && File.file?("./_output/#{@project}/cards.json")
  puts "Project name provided doesn't seem ready in _output folder"
  exit
end

@card_tracker = {}

def create_cards(repo, card_data)
  card_data.each do |card|
    card_id = card['id']
    markdown = File.read("_output/#{@project}/cards/#{card_id}.md")
    issue = @client.create_issue(repo, card['title'], markdown, {labels: card['labels']})
    @card_tracker[card_id] = issue.number
    sleep 1
    print "."
  end
end

def update_card_relationships(repo, cards, tracker)
  cards.each do |card|
    issue_number = tracker[card['id']]

    issue = nil
    if card['childOf'] or card['dependsOn']
      issue = @client.issue(repo, issue_number)

      if card['childOf']
        parent_issue = tracker[card['childOf']]
        issue.body += "\n\nchild of ##{parent_issue}"
      end

      if card['dependsOn']
        card['dependsOn'].each do |dep_card_id|
          ddep_issue = tracker[dep_card_id]
          issue.body += "\n\ndepends on ##{ddep_issue}"
        end
      end

      @client.update_issue(repo, issue_number, issue.title, issue.body)
      sleep 1
      print "."
    end
  end
end

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
# puts @client.rate_limit.inspect
# puts @client.rate_limit.resets_in.inspect

#      client.update_issue(repo, core_number, "#{issue.title} -- in progress", '', labels:['in progress'])

file = File.read("./_output/#{@project}/cards.json")
cards = JSON.parse(file)
# puts cards
create_cards(repo, cards.reverse)
update_card_relationships(repo, cards, @card_tracker)

puts "api calls remaining until reset: #{@client.rate_limit.remaining}"
puts "\ndone!"