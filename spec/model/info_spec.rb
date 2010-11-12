require File.dirname(__FILE__) + '/../spec_helper'

describe Info do
  it "should should count its own paragraphs" do
    info = Info.new
    info.paragraph1 = "text for paragraph 1"
    info.should 
  end
end
