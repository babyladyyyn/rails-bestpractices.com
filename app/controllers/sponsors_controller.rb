class SponsorsController < ApplicationController
  def show
    sponsor = Sponsor.find_cached(params[:id])
    sponsor.sponsor_tracks.create
    redirect_to sponsor.website_url
  end

end
