class AssetsController < ApplicationController
  #Assets are the polymorphic object that holds multiple images for Posts, Users, Groups, etc..
  def index
    @imageable = find_imageable
    @images = @imageable.comments
  end

  def create
    @imageable = find_imageable
    @image = @imageable.assets.build(params[:asset])

    if @image.save
      flash[:notice] = "Successfully created image."
      redirect_to current_user
    else
      render :action => 'new'
    end
  end
  
  def post_create
    @post = Post.find(params[:parent_id])
    @image = @post.attachments.create(params[:attachment])
    if @image.save
      flash[:notice] = "Successfully created image."
      redirect_to current_user
    else
      render :action => 'new'
    end
  end
  
  
  private

  def find_imageable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end