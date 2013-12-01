module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50, circle: false, border: false })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    class_names = ["gravatar"]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    
    if options[:circle]
    	class_names.push("img-circle")
    else
    	class_names.push("img-rounded")
    end

    if options[:border]
    	class_names.push("border")
    end

    image_tag(gravatar_url, alt: user.username, class: "#{class_names.join(" ")}")
  end
end
