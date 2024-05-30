class Deduction < ApplicationRecord
  belongs_to :deductable, polymorphic: true

  monetize :amount_cents
end
