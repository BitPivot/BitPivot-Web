module ErrorsHelper
  def flash_error_placeholders(activeRecord, attr_names)
    errors = activeRecord.errors.to_hash(true)
    attr_names.each do |attr_name|
      if errors[attr_name]
        flash["#{attr_name}_placeholder".to_sym] = errors[attr_name][0]
        flash["#{attr_name}_class".to_sym] = 'error'
      else
        flash[attr_name.to_sym] = activeRecord.attributes[attr_name]
      end
    end
  end
end