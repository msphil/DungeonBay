module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def select_character(character)
    cookies.permanent.signed[:remember_character] = character.id
    self.current_character = character
  end

  def current_user=(user)
    @current_user = user
  end

  def current_character=(character)
    @current_character = character
  end

  def character_selected?
    !current_character.nil?
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_character
    @current_character ||= character_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def current_character?(character)
    character == current_character
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def character_from_remember_token
    Character.find_by_id(*remember_character)
  end

  def remember_character
    cookies.signed[:remember_character] || [nil]
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end

end
