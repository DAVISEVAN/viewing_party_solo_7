class UsersController < ApplicationController
   before_action :require_login, only: [:show]
   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
   end

   def create
      @user = User.new(user_params)
      if @user.save
         session[:user_id] = @user.id
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(@user)
      else
         flash[:error] = @user.errors.full_messages.to_sentence
         redirect_to register_user_path
      end   
   end

   def login_form
     
   end

   def login_user
     user = User.find_by(email: params[:email])
       if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         cookies[:location] = params[:location]
         redirect_to user_path(user), notice: "Welcome, #{user.name}"
       else
         flash[:error] = 'Incorrect email or password'
         render :login_form
       end
   end

   def logout
     session[:user_id] = nil
     redirect_to root_path, notice: 'You have been logged out.'
   end
   



private

  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end