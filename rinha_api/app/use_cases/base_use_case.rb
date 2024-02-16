# frozen_string_literal: true

# Base class for all use cases
class BaseUseCase
  def initialize(*_)
    @started_at = Time.now.to_i
    @finished_at = nil
  end

  def call(*_)
    raise NotImplementedError, "#{self.class} must implement the call method"
  end

  def elapsed_time
    @finished_at - @started_at
  end

  private

  def finish
    @finished_at = Time.now.to_i
  end
end
