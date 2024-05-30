class Payroll < ApplicationRecord
  validates :month, :batch, :for, :status, presence: true

  enum status: {pending: 0, approved: 1, rejected: 2}
  enum for: {part_time: 0, regular: 1, cos: 2}
  enum month: {
    january: 0, february: 1, march: 2, april: 3, may: 4, june: 5,
    july: 6, august: 7, september: 8, october: 9, november: 10, december: 11
  }
end
