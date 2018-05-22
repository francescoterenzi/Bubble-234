class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        #byebug
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env['omniauth.auth'])

        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end

    def twitter
        auth = request.env["omniauth.auth"]
        @user = User.from_omniauth_twitter(auth)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Twitter".capitalize) if is_navigational_format?
        else
          session["devise.twitter_data"] = request.env["omniauth.auth"].except(:extra)
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end

    def failure
        redirect_to root_path
    end
end
