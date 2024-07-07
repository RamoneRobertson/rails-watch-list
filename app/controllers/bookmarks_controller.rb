class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    raise
  end

  private
  def set_list
    @list = List.find(params[list_id])
  end

  def bookmark_params
    params.require(:list)
  end
end
