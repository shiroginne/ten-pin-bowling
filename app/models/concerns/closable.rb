module Closable
  extend ActiveSupport::Concern

  included do
    enum state: [:open, :closed]
  end

  def close!
    update_attribute(:state, :closed)
  end
end
