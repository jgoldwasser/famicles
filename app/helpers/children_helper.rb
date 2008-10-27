module ChildrenHelper

  def gender_options
    [["Male", Child::MALE], ["Female", Child::FEMALE], ["Do not know", Child::UNKNOWN]]
  end

end
