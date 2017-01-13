class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  # get "admin"
  def index
    @users = User.all
  end

  # put/patch "admin/:id"
  def update
    user = User.find(params[:id])
    user.remove_role(user.roles.first.name)
    user.add_role(params[:role])
    redirect_to '/admin'
  end

  # def destroy
  #   user = User.find(params[:id])
  #   user.destroy
  #   user.save
  #   if user.save
  #     redirect_to admin_path
  #   else
  #     render text: "Whoops"
  #   end
  # end

  private

  def authorize
    if !current_user.has_role? :admin
      render text:"No soup for you!"
    end
  end

end
