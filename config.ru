require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'
# require './controllers/BreweryController'
# require './controllers/LocationContoller'



map ('/'){
	run ApplicationController
}

