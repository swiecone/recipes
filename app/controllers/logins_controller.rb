class LoginsController < ApplicationController

	def new

	end 

	def create
		chef = Chef.find_by(email: params[:email])
		if chef && chef.authenticate(params[:password])
			session[:chef_id] = chef.id
			flash[:success] = "#{chef.chefname}, welcome to Recipes App!"
			redirect_to recipes_path

		else
			flash.now[:danger] = "Your email address or password does not match"
			render 'new'
		end
	end 

	def destroy
		if logged_in?
			@chef = current_user
			session[:chef_id] = nil
			flash[:success] = "#{@chef.chefname}, you have logged out correctly."
			redirect_to root_path
		else 
			flash[:danger] = "You must log in before you log out :)"
			redirect_to root_path
		end
			
	end 

end