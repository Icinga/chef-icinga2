def evaluate_quotes(value)
  return value unless value.is_a? String
  if value.to_s =~ /\+|{{(.*?)}}/m
    value
  else
    value.inspect
  end
end

def icinga2_resource_create?(a)
  if a.is_a?(Array) && a == [:create]
    true
  elsif a.is_a?(Symbol) && a == :create
    true
  elsif a.is_a?(String) && a == 'create'
    true
  else
    false
  end
end
