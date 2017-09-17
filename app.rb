#My app starts here!

# require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"
require 'rubygems'
require 'bundler/setup'
Bundler.setup
require 'sinatra'
require 'json'
require 'rest-client'

get '/' do
  api_result = RestClient.get 'https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/imaqtpie?api_key=RGAPI-22fede9a-8304-4616-9def-b936f8177b8b'
  "<p>#{api_result}</p>"
  jhash = JSON.parse(api_result)
   #"<p>#{jhash['accountId']}</p>"
  api_call2 = RestClient.get "https://na1.api.riotgames.com/lol/match/v3/matchlists/by-account/#{jhash['accountId']}?api_key=RGAPI-22fede9a-8304-4616-9def-b936f8177b8b"
  "<p>#{api_call2}</p."
  jhash2 = JSON.parse(api_call2)
 match_id_1 = jhash2['matches'][0]['gameId']
 api_call_three = RestClient.get "https://na1.api.riotgames.com/lol/match/v3/timelines/by-match/#{match_id_1}?api_key=RGAPI-22fede9a-8304-4616-9def-b936f8177b8b"
 "#{api_call_three}"
end
#/lol/static-data/v3/items
#/lol/champion-mastery/v3/champion-masteries/by-summoner/{summonerId}
