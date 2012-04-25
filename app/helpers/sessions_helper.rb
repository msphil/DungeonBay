module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
    if self.current_user.characters[0]
      select_character self.current_user.characters[0]
    end
    if self.current_user.campaigns[0]
      select_campaign self.current_user.campaigns[0]
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
    deselect_character
    deselect_campaign
  end

  def current_character=(character)
    @current_character = character
  end

  def character_selected?
    !current_character.nil?
  end

  def select_character(character)
    cookies.permanent.signed[:remember_character] = character.id
    self.current_character = character
  end

  def deselect_character
    cookies.delete(:remember_character)
    self.current_character = nil
  end

  def current_character
    @current_character ||= character_from_remember_token
  end

  def current_character?(character)
    character == current_character
  end

  def current_campaign=(campaign)
    @current_campaign = campaign
  end

  def campaign_selected?
    !current_campaign.nil?
  end

  def select_campaign(campaign)
    cookies.permanent.signed[:remember_campaign] = campaign.id
    self.current_campaign = campaign
  end

  def deselect_campaign
    cookies.delete(:remember_campaign)
    self.current_campaign = nil
  end

  def current_campaign
    @current_campaign ||= campaign_from_remember_token
  end

  def current_campaign?(campaign)
    campaign == current_campaign
  end

  def current_item=(item)
    @current_item = item
  end

  def item_selected?
    !current_item.nil?
  end

  def select_item(item)
    cookies.permanent.signed[:remember_item] = item.id
    self.current_item = item
  end

  def deselect_item
    cookies.delete(:remember_item)
    self.current_item = nil
  end

  def current_item
    @current_item ||= item_from_remember_token
  end

  def current_item?(item)
    item == current_item
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
    # make sure that we lose the saved character if the user changes
    c = Character.find_by_id(*remember_character)
    if c and signed_in?
      if c.owner_id == current_user.id
        return c
      end
    end
    deselect_character
    return nil
  end

  def remember_character
    cookies.signed[:remember_character] || [nil]
  end

  def campaign_from_remember_token
    # make sure that we lose the saved campaign if the user changes
    c = Campaign.find_by_id(*remember_campaign)
    if c and signed_in?
      if c.owner_id == current_user.id
        return c
      end
    end
    deselect_campaign
    return nil
  end

  def remember_campaign
    cookies.signed[:remember_campaign] || [nil]
  end

   def item_from_remember_token
    # make sure that we lose the saved item if the user changes
    i = Item.find_by_id(*remember_item)
    if i and signed_in? and character_selected?
      c = Character.find(i.owner_id)
      if c.owner_id == current_user.id
        return i
      end
    end
    deselect_item
    return nil
  end

  def remember_item
    cookies.signed[:remember_item] || [nil]
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
