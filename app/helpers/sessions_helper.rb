module SessionsHelper
    
    def current_user
        if session[:id]
          User.find_by(id: session[:id])
        end
    end

    def logged_in?
        !!current_user
    end   
end
