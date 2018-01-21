module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"#?s=#{size} enables size to be specified in users/show.html.erb. 
    image_tag(gravatar_url, alt: user.username, class: "img-circle")#"img-circle" is a bootstrap class that creates a circular image.
  end
end
