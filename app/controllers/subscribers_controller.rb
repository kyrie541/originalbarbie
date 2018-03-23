class SubscribersController < ApplicationController
# http_basic_authenticate_with name: "kyrie", password: "123456",
# except: [:create]

before_action :admin_authorize, :except => [:create]

	def index
		@subscribers = Subsriber.all
	end

	def create
		@subscriber = Subsriber.new(subscriber_params)
		#check if email exists in database table
		if Subsriber.exists?(email: @subscriber.email)
			redirect_to root_path, alert:
			"Sorry, that email already exists!"
		elsif
			@subscriber.save
			redirect_to root_path, notice:
			"Thank You #{@subscriber.f_name}, for subscribing to my Newslatter"
		else 
			redirect_to root_path, alert:
			"Sorry, I failed to save your information, Please try again!"
		end
	end

	#destroy action
	def destroy
		@subscriber = Subsriber.find(params[:id])
		@subscriber.destroy
		redirect_to subscribers_path
	end

private
	def subscriber_params
		params.require(:subscriber).permit(:f_name,:l_name, :email, :country)
	end
end