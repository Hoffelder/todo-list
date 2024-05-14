require './lib/newtodo'

class ToDoList
    attr_accessor :ToDoList

    def initialize
        @todos = []
        @counter = 0
    end 

    def add_new_todo(todo)
        newtodo = NewToDo.new(todo, @counter)
        @counter += 1
        @todos << newtodo.new_todo
    end

    def edit_todo(id, todo)
        @todos[id.to_i][:todo] = todo
    end

    def delete_todo(id)
        @todos.delete_at(id.new_todo_i)
    end

    def complete_todo(id)
        @todos[id.to_i][:completed] = true

    end

    def incomplete_todo(id)
        @todos[id.to_i][:completed] = false

    end

    def delete_done_todos
        @todo[:completed] == true
        end
    end

    def filter_todos(filter)
        value = nil 
        if filter == 'complete'
            value = true
        elsif filter == 'incomplete'
            value = false
        end
    end

    if value == true || value == false
        @todos.select do |todo|
            todo[:completed] == value
        end
        
    else
        @todos
    end

    def count_incomplete_todos
        incomplete = 0
        @todos.each do |todo|
            incomplete += 1 if todo[:completed] == false
        end
        incomplete
    end
