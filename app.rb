require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/newtodo'
require_relative './lib/todolist'
require 'sinatra/custom_logger'
require 'logger'

class App < Sinatra::Base
    use Rack::MethodOverride
    helpers Sinatra::CustomLogger

    configure do 
        logger = Logger.new(STDOUT)
        set :logger, logger
    end

    TODOS = ToDoList.new

    get '/' do 
        @todos = TODOS.todos
        @id = params[:id]
        @status = TODOS.filter_todos(params[:status])
        @counter = TODOS.count_incomplete_todos

        erb :index
    end

    post '/todos/' do 
        TODOS.add_new_todo(params[:todo])
        redirect '/'
    end

    get '/todos/:id/edit' do 
        @todos = TODOS.todos
        @id = params[:id]
        @idnum = @id.to_i
        @todotext = @todos[@idnum][:todo]
        erb :edit
    end

    put '/todos/:id/edit' do
        TODOS.edit_todo(params[:id], params[:todo])
        redirect '/'
    end

    delete '/todos/:id' do 
        TODOS.delete_todo(params[:id])
        redirect '/'
    end

    put '/todos/:id/complete' do 
        TODOS.complete_todo(params[:id])
        redirect '/'
    end

    put '/todos/:id/incomplete' do 
        TODOS.incomplete_todo(params[:id])
        redirect '/'
    end

    post '/todos/delete_done' do 
        TODOS.delete_done_todos
        redirect '/'
    end
end
