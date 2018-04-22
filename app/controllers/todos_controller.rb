class TodosController < ApplicationController

    def index
        json_response(current_user.todos)
    end

    def show
        json_response(Todo.find(params[:id]))
    end

    def create
        json_response(current_user.todos.create!(todo_params), :created)
    end

    def update
        Todo.update(todo_params)
        head :no_content
    end

    def destroy
        Todo.find(params[:id]).destroy
        head :no_content
    end

    private
    def todo_params
        params.permit(:title)
    end
end
