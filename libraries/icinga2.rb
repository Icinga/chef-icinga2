def evaluate_quotes(value)
  return value unless value.is_a? String
  if value.to_s.match(/\+/)
    value
  else
    value.inspect
  end
end
