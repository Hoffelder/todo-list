require 'todolist'

RSpec.describe ToDoList do 

    todo_list = nil
    before(:each) do 
        todo_list = ToDoList.new()
    end


    it "creates a new instance of the ToDoList class" do 
        expect(todo_list.is_a?Object).to eq(true)
    end

    it "adds a new todo as a hash to @todos" do 
        todo_list.add_new_todo("Buy milk")
        expect(todo_list.todos[0]).ro eq({
            todo: "Buy milk",
            completed: false,
            id: 0,
        })
    end
end

RSpec.describe ToDoList do

    todo_list = nil
    before(:each) do
        todo_list = ToDoList.new()
        todo_list.add_new_todo("Buy milk")
        todo_list.add_new_todo("Pick up kids")
        todo_list.add_new_todo("Wash car")
        todo_list.add_new_todo("Call sister")
    end

    it "deletes an existing todo" do 
        todo_list.delete_todo(1)
        expect(todo_list.todos).not_to include("Pick up kids")

    end

    it "marks a todo as complete - @completed = true" do
        todo_list.complete_todo(0)
        expect(todo_list.todos[0][:completed]).to eq(true)
    end

    it "marks a todo as not complete - @completed = false" do
        todo_list.complete_todo(1)
        todo_list.incomplete_todo(1)
        expect(todo_list.todos[0][:completed]).to eq(false)
    end

    it "deletes complete todos - when @completed = true" do 
        todo_list.complete_todo(0)
        todo_list.complete_todo(1)
        todo_list.delete_done_todos
        expect(todo_list.todos.length).to eq(2)
    end

    it "returns the completed todos only" do 
        todo_list.complete_todo(0)
        todo_list.complete_todo(2)
        expect(todo_list.filter_todos("complete")).to eq([
        {
            todo: "Buy milk",
            completed: true,
            id: 0,  
        },
        {
            todo: "Wash car",
            completed: true,
            id: 2,
        }])
    end

    it "returns the incomplete todos only" do
        todo_list.complete_todo(0)
        todo_list.complete_todo(2)
        expect(todo_list.filter_todos("incomplete")).to eq([{
            todo: "Pick up kids",
            completed: false, 
            id: 1,
        },
        {
            todo: "Call sister",
            completed: false, 
            id: 3,
        }])
    end

    it "returns all of the todos, completed and not completed" do 
        todo_list.complete_todo(0)
        todo_list.complete_todo(2)
        expect(todo_list.filter_todos("all")).to eq([{
            todo: "Buy milk",
            completed: true,
            id: 0,
        },
        {
            todo: "Pick up kids",
            completed: false,
            id: 1,
        },
        {
            todo: "Wash car",
            completed: true,
            id: 2,
        },
        {
            todo: "Call sister",
            completed: false,
            id: 3,
        }])
    end

    it "returns the total number of incomplete todos" do 
        todo_list.complete_todo(0)
        todo_list.complete_todo(2)
        expect(todo_list.count_incomplete_todos).to eq(2)
    end

end