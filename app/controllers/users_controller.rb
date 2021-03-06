class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @plan = @user.plan ? @user.plan : Plan.new
    @activity = Activity.new
  end
end