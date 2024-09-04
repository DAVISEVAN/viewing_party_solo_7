class ApplicationController < ActionController::Base
   def require_login
      unless session[:user_id]
        flash[:error] = 'You must be logged in to access this page'
        redirect_to root_path
      end
    end
   private

   def error_message(errors)
      errors.full_messages.join(', ')
   end
end
