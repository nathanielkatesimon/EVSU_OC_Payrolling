class Payroll < ApplicationRecord
  has_many :part_time_entries, dependent: :destroy
  has_many :cos_entries, dependent: :destroy
  has_many :regular_entries, dependent: :destroy
  after_update :generate_payslips
  after_update :clear_excluded_entries
  after_create :create_entries

  validates :month, :batch, :for, :status, presence: true

  enum status: {pending: 0, forwarded_to_accounting: 1, ready_for_ada: 2, completed: 3 }
  enum for: {part_time: 0, regular: 1, cos: 2}
  enum month: {
    january: 0, february: 1, march: 2, april: 3, may: 4, june: 5,
    july: 6, august: 7, september: 8, october: 9, november: 10, december: 11
  }

  def deduction_types
    @deduction_types ||= User.includes(:deductions).send(user_type).map { |user| user.deductions.pluck(:name) } .flatten.uniq
  end

  private
    def user_type
      @user_type ||= case self.for
                    when "part_time"
                      :part_time
                    when "cos"
                      :cos
                    when "regular"
                      :regular
                    end  
    end

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

    def clear_excluded_entries
      return unless status == "forwarded_to_accounting"
      

      key = case self.for
      when "part_time"
        :part_time_entries
      when "cos"
        :cos_entries
      when "regular"
        :regular_entries
      end

      self.send(key).where(included: false).each do |entry|
        entry.destroy
      end
    end

    def create_entries
      if self.for == "part_time"
        user_type = :part_time
        entry_type = :part_time_entries
      elsif self.for == "cos"
        user_type = :cos
        entry_type = :cos_entries
      elsif self.for == "regular"
        user_type = :regular
        entry_type = :regular_entries
      end
      
      User.send(user_type).each do |user|
        self.send(entry_type).find_or_create_by(user: user, total_rendered_hours: 0)
      end
    end
end
