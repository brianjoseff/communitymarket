class ExceptionsController < ApplicationController
  

  def not_found
    # centralize all rendering of 404 into app controller
    #raise Communitymarket::NotFound
  end

end