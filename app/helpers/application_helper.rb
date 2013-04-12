module ApplicationHelper

  # Sets (if passed argument) or gets a page title
  # Defaults should be set in config/app_config.yml
  #
  def title(new_title = nil)
    if new_title.nil?
      content_for?(:title) ? content_for(:title) : APP_CONFIG['default_page_title']
    else
      content_for :title, new_title
    end
  end

  # Sets (if passed argument) or gets a meta description for the page
  # Defaults should be set in config/app_config.yml
  #
  def meta_description(new_description = nil)
    if new_description.nil?
      content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['default_meta_description']
    else
      content_for :meta_description, new_description
    end
  end

  # Sets (if passed argument) or gets meta keywords for the page
  # Defaults should be set in config/app_config.yml
  #
  def meta_keywords(new_keywords = nil)
    if new_keywords.nil?
      content_for?(:meta_keywords) ? content_for(:meta_keywords) : APP_CONFIG['default_meta_keywords']
    else
      content_for :meta_keywords, new_keywords
    end
  end

end
