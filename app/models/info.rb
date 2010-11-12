class Info < ActiveRecord::Base

  before_save :count_paragraphs
  
  # discontiguous paragraphs get ignored after the empty one
  def count_paragraphs
    self.number_of_paragraphs = 0
    if not self.paragraph1.blank?
      self.number_of_paragraphs += 1
      if not self.paragraph2.blank?
        self.number_of_paragraphs += 1
        if not self.paragraph3.blank?
          self.number_of_paragraphs += 1
          if not self.paragraph4.blank?
            self.number_of_paragraphs += 1
          end
        end
      end
    else
      self.errors.add_to_base "Don't create info without any paragraphs!"
      return false
    end
  end

end
