module FrontHelper
  def blank_or_check(num_to_match, array_to_match)
    if array_to_match.include?(num_to_match)
      return "_X_ "
    else
      return "___ "
    end
  end
  
  
  def set_to_blanks(text, blank_line_length)
    if text == nil
      text = ""
    end
    if text.blank?
    	if blank_line_length != nil and text.length == 0
    		blank_answer = ""
    		blank_line_length.times { blank_answer += "_" }
    		text = blank_answer
    	else
    		text = "________"
    	end
    end
    return text
  end
end
