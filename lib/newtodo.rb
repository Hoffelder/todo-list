class NewToDo
    attr_accessor :todo, :completed, :id 

    def initialize(todo, id = nil)
        @todo = todo
        @completed = false
        @id = id 
        
    end

    def new_todo
        {
            todo: @todo,
            completed: @completed,
            id: @id
        }
    end
end