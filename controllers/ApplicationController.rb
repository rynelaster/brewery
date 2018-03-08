class ApplicationController < Sinatra::Base

require 'http'
require 'brewery_db'


	require 'bundler'
	Bundler.require()

	
	register Sinatra::CrossOrigin

	set :allow_origin, :any
	set :all_methods, [:get, :post, :options, :put, :patch, :delete]
	set :allow_credentials, true

	configure do
		enable :cross_origin	
	end

	not_found do
		halt 404
	end

	options '*' do
		response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
		respnse.headers['Access-Control-Allow-Origin'] = '*'

		respnse.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
	end

	

	# BreweryDB Gem

	brewery_db = BreweryDB::Client.new do |config|
	  config.api_key = '262ffd433f83ede508850a0a4a1c01fd'
	end





	use Rack::MethodOverride
	set :method_override, true

	get '/locations' do  
		# HTTP.get('http://api.brewerydb.com/v2/locations/?key=262ffd433f83ede508850a0a4a1c01fd').body
		locs = brewery_db.locations.all(locality: 'San Francisco')
		locs.to_json
	end

	get '/unitedstates' do
		# us = brewery_db.breweries.all(country: 'Brazil')
		# us.to_json
		HTTP.get('http://api.brewerydb.com/v2/locations/?countryIsoCode=US&key=262ffd433f83ede508850a0a4a1c01fd').body
	end
	# get '/beers' do
	# 	brewery_db.search.breweries(q: 'IPA');
	# end

	# get '/breweries/in/:city' do
	# 	breweries = brewery_db.locations.all(locality: params[:city]);
	# 	breweries.to_json

	# end

	# get '/random' do
	# 	randoms = brewery_db.beers.random;
	# 	randoms.to_json
	# end















end