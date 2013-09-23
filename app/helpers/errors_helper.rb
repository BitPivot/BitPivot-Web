module ErrorsHelper
  def flash_error_placeholders(activeRecord, attr_names, prefix = '')
    errors = activeRecord.errors.to_hash(true)
    attr_names.each do |attr_name|
      if errors[attr_name]
        flash["#{prefix}#{attr_name}_placeholder".to_sym] = errors[attr_name][0]
        flash["#{prefix}#{attr_name}_class".to_sym] = 'error'
      else
        flash["#{prefix}#{attr_name}".to_sym] = activeRecord.attributes[attr_name.to_s]
      end
    end
  end
end