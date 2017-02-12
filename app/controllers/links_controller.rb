class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(
                        user_id: 1,
                        slug: params[:slug],
                        target_url: params[:target_url]
                        )
    @link.standardize_target_url!

    redirect_to '/links'
  end

  def show
    @link = Link.find_by(:id => params[:id], :user_id => 1)

    unless @link
      flash[:warning] = "Link not found"
      redirect_to "/index"
    end
  end

  def edit
    @link = Link.find_by(:id => params[:id], :user_id => 1)
  end

  def update
    @link = Link.find_by(:id => params[:id], :user_id => 1)

        if @link && @link.update(:slug => params[:slug], :target_url => params[:target_url])
          @link.standardize_target_url!
          flash[:success] = "Link created successfully"
          redirect_to "/links/#{params[:id]}"
        else
          render 'edit'
        end
  end

  def destroy
      @link = Link.find_by(:id => params[:id], :user_id => 1)

      if @link && @link.destroy
        redirect_to "/links"
      else
        redirect_to "/links/#{params[:id]}"
      end
    end

end
