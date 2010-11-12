# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # return text truncated to count with ... appended if text was indeed truncated
  def truncate_string(text, count)
    return_string = text
    if text.length > count
        return_string = text[0, count]
        return_string = return_string + "..."
    end
    return return_string
  end

end
