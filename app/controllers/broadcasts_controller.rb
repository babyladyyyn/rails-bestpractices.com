class BroadcastsController < ApplicationController
  def close
    cookies[:chinese_entry]  = {
      :value => "false",
      :expires => 1.year.from_now
    }
    redirect_to root_path
  end
end
