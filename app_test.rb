ENV['RACK_ENV'] = 'test'

require './app'
require 'test/unit'
require 'rack/test'

class ToDoTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App.new!
  end

  def test_it_adds_item_to_todo_list
    post '/todos/', todo: 'Make tea'
    get '/'
    assert last_response.body.include?('Make tea')
  end

  def test_it_edits_item_in_todo_list
    put '/todos/0/edit', todo: 'Get milk'
    get '/'
    assert last_response.body.include?('Get milk')
  end

  def test_it_deletes_item_in_todo_list
    post '/todos/', todo: 'Go shopping'
    delete '/todos/1'
    get '/'
    assert last_response.body.include?('Go shopping')
  end

  def test_it_marks_item_as_completed
    put '/todos/0/complete'
    get '/'
    assert  last_response.body.include?('<p class="todo completed">Get milk')
  end

  def test_it_marks_item_as_incomplete
    put '/todos/0/incomplete'
    get '/'
    assert last_response.body.include?('<p class="todo incomplete">Get milk')
  end 

  def test_deletes_completed_items_from_list 
    post '/todos/', todo: 'Go shopping'
    post '/todos/', todo: 'Pick up kids'
    put '/todos/0/complete'
    put '/todos/1/complete'
    post '/todos/delete_done'
    get '/'
    puts last_response.body
    assert !last_response.body.include?('Go shopping')

  end

  def test_it_displays_completed_todos_only
    post '/todos', todo: 'Go shopping'
    post '/todos', todo: 'Pick up kids'
    put '/todos/0/complete'
    put '/todos/1/complete'
    get '/', status: 'complete'
    assert !last_response.body.include?('Pick up kids')
  end

  def test_it_displays_incomplete_todos_only
    get '/', status: 'incomplete'
    assert !last_response.body.include?('Pick up kids')
  end

  def test_it_displays_number_of_incomplete_todos
    get '/'
    puts last_response.body
    assert last_response.body.include?('Items to complete: 1')
  end

end