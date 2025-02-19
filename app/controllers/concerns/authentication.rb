module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end

    def disallow_authenticated_access(**options)
      before_action :require_guest, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_guest
      redirect_to adventure_path if authenticated?
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def request_authentication
      redirect_to new_session_path
    end

    def start_new_session_for(user)
      user.sessions.create.tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      end
      user.update_last_login_time
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
