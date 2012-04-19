require 'rubygems'
require 'sinatra'
require 'haml'
require 'uri'
require 'faraday'

# Helpers
require './lib/render_partial'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml

# Application routes
get '/' do
  haml :index, :layout => :'layouts/application'
end

get '/hubot-storage*' do
  couch_proxy request
end
post '/hubot-storage*' do
  couch_proxy request
end

def couch_proxy request
  path = request.path
  path << "?#{request.query_string}" unless request.query_string.empty?
  res = proxy_conn.send request.request_method.downcase do |req|
    req.url path
    req.headers['Content-Type'] = 'application/json'
    req.body = request.body.read
  end

  content_type 'application/json'
  res.body
end

def proxy_conn
  @conn ||= Faraday.new(:url => 'http://127.0.0.1:5984') do |builder|
    builder.request  :url_encoded
    builder.adapter  :net_http
  end
end
