class SearchesController < ApplicationController
  def index
    if params[:search].blank?
      @results = Post.search_place params[:place_id]
    elsif params[:place_id].blank?
      @results = Post.search_title params[:search].upcase
    end
    return if @results.present?
    flash[:info] = "Title or Place Invalid"
    redirect_to root_url
  end
end
