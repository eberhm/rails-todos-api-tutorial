module V1
    class ItemsController < ApplicationController

        def index
            json_response(get_todo.items)
        end

        def show
            json_response(get_item)
        end

        def create
            json_response(get_todo.items.create!(item_params), :created)
        end

        def update
            get_item.update(item_params)
            head :no_content
        end

        def destroy
            get_item.destroy
            head :no_content
        end

        private
        def item_params
            params.permit(:name, :done)
        end

        def get_todo
            Todo.find(params[:todo_id])
        end

        def get_item
            Item.find(params[:id])
        end
    end
end
