require "api_utils/version"

module ApiUtils
  module_function

  # Convert a string from "something_like_this" to "somethingLikeThis"
  # @param [String] underscored_word
  # @return [String]
  def camelize(underscored_word)
    underscored_word.gsub(/(?:_)(.)/) { Regexp.last_match(1).upcase }
  end

  # camelize all hash keys
  # @param [Hash] hash
  # @return [Hash]
  def camelize_keys(hash) # rubocop:disable Metrics/MethodLength
    hash.each.with_object({}) do |(key, val), obj|
      obj[camelize(key.to_s)] =
        case val
        when Hash
          camelize_keys(val)
        when Array
          val.map do |item|
            item.instance_of?(Hash) ? camelize_keys(item) : item
          end
        else
          val
        end
    end
  end

  # symbolize all hash keys
  # @param [Hash] hash
  # @return [Hash]
  def symbolize_keys(hash) # rubocop:disable Metrics/MethodLength
    hash.each.with_object({}) do |(key, val), obj|
      obj[key.to_sym] =
        case val
        when Hash
          symbolize_keys(val)
        when Array
          val.map do |item|
            item.instance_of?(Hash) ? symbolize_keys(item) : item
          end
        else
          val
        end
    end
  end
end
