class RatesController < ApplicationController
  before_action :load_rate, except: [:new, :create]
  before_action :load_post

  def new
    @rate = @post.rates.build
  end

  def create
    @rate = @post.rates.build rates_params
    if current_user? @rate.user
      if @rate.save
        flash[:success] = "Rated Post !!"
        redirect_to @post
      else
        flash[:warning] = "Rate Fail"
        redirect_to @post
      end
    else
      flash[:warning] = "Rate Fail"
      render :new
    end
  end

  def edit; end

  def update
    if @rate.update rates_params
      flash[:success] = "Updated!!"
      redirect_to @post
    else
      flash[:warning] = "Update Fail"
      render :edit
    end
  end

  def destroy
    if @rate.destroy
      flash[:success] = "Deleted Rate"
    else
      flash[:info] = "Delete Error!!"
    end
    redirect_to @post
  end

  private

  def rates_params
    params.require(:rate).permit :star, :review, :user_id
  end

  def load_rate
    @rate = Rate.find_by id: params[:id]
    return if @rate.present?
    flash[:warning] = "Rate Invalid!"
    redirect_to @post
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
  end
end
