require 'sinatra/base'
require './game'
require './frame'
require './last_frame'

class Bowling < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "secret"
  end
  
  before "/" do
    @game = session[:game] || Game.new
  end
  
  get '/' do
    erb :game
  end

  post '/' do
    @game.roll!(params[:score])
    session[:game] = @game
    # erb :game
    redirect to('/')
  end
  
  get '/new' do
    session.clear
    redirect to('/')
  end
end
