class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render json: @micropost, status: 201
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end

  def like
    @micropost = Micropost.find_by(id: params[:id])
    unless @micropost.nil?
      @micropost.likes+=1
      @micropost.save
    end
    redirect_to root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, category_ids:[], categories_attributes: [:title])
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
