class BroadcastsController < ApplicationController
  def close
    session[:chinese_entry]  = "false"
    redirect_to root_path
  end
end
