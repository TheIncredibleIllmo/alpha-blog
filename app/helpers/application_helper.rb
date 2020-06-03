module ApplicationHelper
  def gravatar_for(user, options = { size: 200 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "shadow-lg mx-auto d-block m-4 circle-img")
  end

  def current_user
    #one option or the other
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!! transforms the result in a boolean
    !!current_user
  end
end
