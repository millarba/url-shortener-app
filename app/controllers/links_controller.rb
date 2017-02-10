class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def new

  end

  def create
    @link = Link.create(
                        user_id: current_user,
                        slug: params[:slug],
                        target_url: params[:target_url]
                        )
  end

end
