# frozen_string_literal: true

ActionDispatch::Request.parameter_parsers[:json] = lambda { |raw_post|
  data = ActiveSupport::JSON.decode(raw_post)

  if data.is_a?(Array)
    data.each { |item| item.deep_transform_keys!(&:underscore) }
  else
    data.deep_transform_keys!(&:underscore)
  end

  if data.is_a?(Hash)
    data
  else
    { '_json': data }
  end
}
