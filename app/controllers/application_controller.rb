class ApplicationController < ActionController::Base
   before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit? #dont touch
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit? #dont touch

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
      new_owner_session_path
  end
end
