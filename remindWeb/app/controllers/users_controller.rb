class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user  = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		log_in @user
  		redirect_to @user
  		flash[:success] = "Welcome to the Remind"
  	else
  		render 'new'
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = "You have successfully updated your profile"
  		redirect_to users_url
  	else
  		render 'edit'
  	end
  end

  private 
    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
	    unless logged_in?
	    	store_location
	   		flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_url) unless current_user?(user)
  	end
end
