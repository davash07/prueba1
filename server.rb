
  require 'sinatra'
  require 'json'
  require 'rest-client'
  # use Rack::Logger
  #
  # svc = OData::Service.new "http://api.sundevs.com/api/v1/cards/quantity"
  # flight = svc.execute
  # before /.*/ do
  # content_type :json
  # end
  #
  # get '/gateway_flights' do
  #   flight.to_json
  # end
  use Rack::Logger
  url = 'http://people.zoho.com/people/api/forms/P_TimesheetJobsList/getRecords?authtoken=6a701202eb76ebf85132b6ba39f6831d'
  response = RestClient.get(url)
  before /.*/ do
    content_type :json
  end

  get '/api' do
    response.to_json
  end

  before do
     content_type :json
     headers 'Access-Control-Allow-Origin' => '*',
  		   'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
  		   'Access-Control-Allow-Headers' => 'Content-Type'
  end

  set :protection, false

  options '/movie' do
  	200
  end

  get '/movie' do
    { result: "Monster University" }.to_json
  end

  post '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: params[:movie], seen: true, method: 'POST' }.to_json
  end

  put '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: params[:movie], updated: true, method: 'PUT' }.to_json
  end

  delete '/movie' do

    begin
      params.merge! JSON.parse(request.env["rack.input"].read)
    rescue JSON::ParserError
      logger.error "Cannot parse request body." 
    end

    { result: "#{params[:movie]} deleted!", method: 'DELETE' }.to_json
  end