class CustomFormBuilder < Formtastic::SemanticFormBuilder
  def date_input(method, options)
    current_value = @object.send(method)
    html_options ||= {:value => current_value ? current_value.to_s : @object.send("#{method}_before_type_cast")}
    self.label(method, options.delete(:label), options.slice(:required)) + self.send(:text_field, method, html_options)
  end
end