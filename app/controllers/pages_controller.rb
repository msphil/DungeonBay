class PagesController < ApplicationController

  def home
    @title = "Home"
    @item = Item.new if signed_in?
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
