class SponsorsController < ApplicationController
  def show
    sponsor = Sponsor.find(params[:id])
    sponsor.sponsor_tracks.create
    redirect_to sponsor.website_url
  end

end
