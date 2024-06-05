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

  def excluded_users
    return @excluded_users unless @excluded_users.nil?
    excluded_users_id = Payroll.send(user_type).where(month: month).map(&:users_id).flatten
    @excluded_users = User.send(user_type).where.not(id: excluded_users_id)
    @excluded_users
  end

  def users_id
    @users_id ||= self.send(entry_type).map(&:user).pluck(:id)
  end

  def deduction_types
    @deduction_types ||= User.includes(:deductions).send(user_type).map { |user| user.deductions.pluck(:name) } .flatten.uniq
  end

  def prev_month
    @prev_month ||= Date.parse(month) - 1.month
  end

  private
    def entry_type
      @entry_type ||= case self.for
                      when "part_time"
                        :part_time_entries
                      when "cos"
                        :cos_entries
                      when "regular"
                        :regular_entries
                      end
    end

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

      # self.send(entry_type).each do |entry|
      #   Payslip.find_or_create_by(entry: entry, user_id: entry.user_id)
      # end
    end

    def clear_excluded_entries
      return unless status == "ready_for_ada"

      self.send(entry_type).where(included: false).each do |entry|
        entry.destroy
      end
    end

    def create_entries
      collection = batch > 1 ? excluded_users : User.send(user_type)

      collection.each do |user|
        entry = self.send(entry_type).find_or_create_by(user: user)
      end
    end
end
