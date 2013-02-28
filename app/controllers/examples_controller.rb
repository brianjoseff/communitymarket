class ExamplesController < ApplicationController


  def index
    @examples = Example.all
    @example = Example.new 
  end

  def create
    @example = Example.create(params[:example])
    render
  end

end
