module ChildrenHelper

  def gender_options
    [["Male", Child::MALE], ["Female", Child::FEMALE], ["Do not know", Child::UNKNOWN]]
  end

  def prearrival_path
    if @child.prearrival.blank?
      link_to("Add Prearrival Info", new_famicle_child_prearrival_path(@child.famicle, @child))
    else
      link_to("Edit Prearrival Info", edit_famicle_child_prearrival_path(@child.famicle, @child, @child.prearrival))
    end
  end
end
