class TodosController < ApplicationController
    include Response
    include ExceptionHandler

    def index
        json_response(Todo.all)
    end

    def show
        json_response(Todo.find(params[:id]))
    end

    def create
        json_response(Todo.create!(todo_params), :created)
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
        params.permit(:title, :created_by)
    end
end
