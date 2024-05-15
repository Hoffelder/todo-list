require 'newtodo'

RSpec.describe NewToDo do 
    new_todo = nil 

    before(:each) do 
        new_todo = NewToDo.new("Wash clothes", 1)
    end

    it "creates a new instance of the NewTodo class" do 
        expect(new_todo.is_a?Object).to eq(true)

    end

    it "creates a new instance of the NewToDO class with 'Wash clothes as the value of @todo" do 
        expect(new_todo.todo).to eq("Wash clothes")
    end

    it "creates a new instance of the NewToDo class with false as the value of @completed" do 
        expect(new_todo.completed).to eq(false)
    end

    it "creates a new instance of the NewToDo class with 1 as the value of @id" do 
        new_todo = NewToDo.new("Wash clothes", 1)
        expect(new_todo.id).to eq(1)
    end

    it "creates a hash with the todo instance variables as the values" do 
        expect(new_todo.new_todo).to eq({
            todo: "Wash clothes",
            completed: false,
            id: 1   
        })
    end

end

