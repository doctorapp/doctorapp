module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "go see a doctor!"
    if page_title.empty?
      base_title
    else
      "#{base_title}  |  #{page_title}"
    end
  end

	def profile_page(user)
		if user.type == 'Admin'
			doctors_path
		else
			user
		end
	end
	

end
