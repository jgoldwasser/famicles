module VirtualModelAttributes

private
  def set_new_model_attributes(name, model_attributes)
    model_attributes.each do |attributes|
      send(name).build(attributes.merge({self.class.name.downcase.to_sym => self}))
    end
  end

  def set_existing_model_attributes(name, model_attributes, sub_model=nil, sub_model_class=nil)
    send(name).reject(&:new_record?).each do |model|
      attributes = model_attributes[model.id.to_s]
      if attributes
        model.attributes = attributes
        model.write_attribute(sub_model, sub_model_class.find_or_initialize_by_name(attributes["#{sub_model}_name".to_sym])) unless sub_model.nil?
      else
        send(name).delete(model)
      end
    end
  end
end