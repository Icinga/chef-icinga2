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

def icinga_format(toplevel)
  case toplevel
  when Hash
    rval = '{ '
  when Array
    rval = '[ '
  when NilClass
    return 'null'
  when String, Float, Fixnum
    return toplevel.inspect
  when Symbol
    return toplevel.to_s.inspect
  else
    return toplevel.inspect.to_s.inspect
  end

  rval += toplevel.collect do |k, v|
    prefix = ''

    target = k
    case toplevel
    when Hash
      prefix += "#{icinga_format(k)} = "
      target = v
    end

    prefix + icinga_format(target)
  end.join(', ')

  case toplevel
  when Hash
    rval += ' }'
  when Array
    rval += ' ]'
  end

  rval
end
