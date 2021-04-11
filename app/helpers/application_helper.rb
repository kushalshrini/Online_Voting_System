module ApplicationHelper
  def current_user
    Voter.find_by_id(session[:user_id]) if session[:user_id]
  end
end
