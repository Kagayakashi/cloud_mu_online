class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, to: :session, allow_nil: false
  delegate :character, to: :user, allow_nil: true
end
