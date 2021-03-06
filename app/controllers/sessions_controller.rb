class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(user_email: params[:session][:user_email].downcase)
		if user
			if user.user_status == 1
				redirect_to (user_shutdown_path) and return
		             elsif user.authenticate(params[:session][:password])
		             	sign_in user
			             redirect_back_or user
			end
		else
			flash.now[:error] = "No Such User" #'Invalid email/password combination'
      		             render 'new'
		end
	end

	def destroy
    sign_out
    redirect_to root_path
  end
end
