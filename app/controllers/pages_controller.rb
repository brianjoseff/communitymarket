class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  def index
    @post = Post.new
  end
  def about
  end
  
end

