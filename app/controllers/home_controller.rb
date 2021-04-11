class HomeController < ApplicationController

  def index
    if params["voted"] == "true"
      session["voted"] = true
    end
  end

end
