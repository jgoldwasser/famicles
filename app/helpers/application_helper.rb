# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str, container = nil)
    @page_title = str
    content_tag(container, str) if container
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "flash", :class => msg) unless flash[msg.to_sym].blank?
    end
    messages
  end

  # General Options for Public Private selects
  def public_private_options
    [["Public", ApplicationController::PUBLIC], ["Private", ApplicationController::PRIVATE]]
  end

  def show_famicle_menu?
    logged_in? && current_user.default_famicle.blank? == false
  end

  def required
    image_tag('circle_red.png', :alt => 'required')
  end
end
