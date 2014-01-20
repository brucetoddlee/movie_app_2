require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'


get "/" do
	erb :index
end

post '/result' do
	search_str = params[:movie]

	# Make a request to the omdb api here!
	response = Typhoeus.get("http://www.omdbapi.com/", :params => { :s => search_str })
	result = JSON.parse(response.body)
	@movies_arr = result["Search"].sort{ |el1, el2| el1["Year"] <=> el2["Year"] }.reverse

	erb :results
end

get '/poster/:imdb' do |imdb_id|
  
	# Make another api call here to get the url of the poster.
	response = Typhoeus.get("http://www.omdbapi.com/", :params => { :i => imdb_id })
	@result2 = JSON.parse(response.body)

	erb :poster
end

