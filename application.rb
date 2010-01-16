# require 'rubygems'
require 'sinatra/base'
require 'haml'

module Application

  set :haml, {:format => :html5, :attr_wrapper => '"'}
  # set :environment => 'production' # for testing minification etc
  
  class App < Sinatra::Application
    Dir.glob("lib/helpers/*").each do |helper|
      require "#{File.dirname(__FILE__)}/#{helper}"
    end

    helpers do
      include Application::Helpers
    end
    
    configure do
      #configure_avatars(Dir.glob("public/images/userlist.yaml")[0])
    end
    
    before do
      !mobile_request? ? @mobile = ".mobile" : @mobile = ""
    end

    error do
      handle_fail
    end

    not_found do
      handle_fail
    end
    
    # homepage
    get '/' do
      haml :"index#{@mobile}"
    end

    get '/:page/' do
      haml params[:page].to_sym
    end

  end
end
