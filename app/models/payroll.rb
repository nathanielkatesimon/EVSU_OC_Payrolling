class Payroll < ApplicationRecord
  has_many :part_time_entries, dependent: :destroy
  has_many :cos_entries, dependent: :destroy
  has_many :regular_entries, dependent: :destroy
  after_update :generate_payslips

  validates :month, :batch, :for, :status, presence: true

  enum status: {pending: 0, forwarded_to_accounting: 1, ready_for_ada: 2, completed: 3 }
  enum for: {part_time: 0, regular: 1, cos: 2}
  enum month: {
    january: 0, february: 1, march: 2, april: 3, may: 4, june: 5,
    july: 6, august: 7, september: 8, october: 9, november: 10, december: 11
  }

  private

    def generate_payslips
      return unless status == "completed"

      key = case self.for
            when "part_time"
              :part_time_entries
            when "cos"
              :cos_entries
            when "regular"
              :regular_entries
            end

      self.send(key).each do |entry|
        Payslip.find_or_create_by(entry: entry, user_id: entry.user_id)
      end
    end
end
