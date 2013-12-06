module ApplicationHelper
	def full_title(page_title)
		base_title = "Code"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def javascript(*files)
	  content_for(:head) { javascript_include_tag(*files) }
	end
end
