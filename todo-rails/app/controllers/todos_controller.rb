#     todos GET    /todos(.:format)          todos#index
#           POST   /todos(.:format)          todos#create
#  new_todo GET    /todos/new(.:format)      todos#new
# edit_todo GET    /todos/:id/edit(.:format) todos#edit
#      todo GET    /todos/:id(.:format)      todos#show
#           PUT    /todos/:id(.:format)      todos#update
#           DELETE /todos/:id(.:format)      todos#destroy


class TodosController < ApplicationController
  # GET
  def index
    todos = Todo.find(:all)

     respond_to do |format|
      format.json { render :json => todos.to_json, :status => 200 }
    end
  end

  # POST
  def create

    todo = Todo.create!(
      title: params[:title],
      completed: false
    )

    respond_to do |format|
      format.json { render :json => todo.to_json, :status => 201 }
    end

  end

  def update

    todo = Todo.find(params[:id])

    todo.update_attributes!(
      title: params[:title],
      completed: params[:completed]
    )

    respond_to do |format|
      format.json { render :json => todo.to_json}
    end

  end

  def destroy

    todo = Todo.find(params[:id])

    todo.delete

    respond_to do |format|
      format.json { render :json => "{}", :status => 204 }
    end

  end
end