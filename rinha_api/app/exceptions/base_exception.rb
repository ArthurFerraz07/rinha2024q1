# frozen_string_literal: true

# Error raised by the application
class BaseException < StandardError
  attr_accessor :code

  MESSAGES = {
    'default' => 'An error occurred',
    'unexpected_error' => 'An unexpected error occurred'
  }.freeze

  def initialize(code: nil, message: nil)
    @code = code
    if message
      super(message)
      return
    end

    if code && MESSAGES[code]
      super(MESSAGES[code])
      return
    end

    super(MESSAGES['default'])
  end

  def inspect
    "#{self.class.name}: #{@code} - #{message}"
  end
end
