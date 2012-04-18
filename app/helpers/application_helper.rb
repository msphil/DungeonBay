module ApplicationHelper

  def logo
    logo = image_tag("dblogo.png", :alt => "DungeonBay", :class => "round")
  end

  def title
    base_title = "DungeonBay"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
