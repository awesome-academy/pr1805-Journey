class SearchesController < ApplicationController
  def index
    if params[:search].present?
      @results = Post.search_title params[:search]
      if params[:place_id].present?
        @results = Post.search_place params[:place_id]
      end
    end
    if params[:search].blank?
      @results = Post.search_place params[:place_id]
    elsif params[:place_id].blank?
      @results = Post.search_title params[:search]
    end
    return if @results.present?
    flash[:info] = "Opps!!Invalid Title or Place "
    redirect_to root_url
  end
end
