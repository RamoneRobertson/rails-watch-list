class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  private
  def set_list
    @list = List.find(params[:id])
  end
end
