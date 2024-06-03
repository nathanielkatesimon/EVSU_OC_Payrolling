class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name, :last_name, :role, :department, :employment_type, presence: true

  monetize :basic_pay_cents, :hourly_rate_cents, :daily_rate_cents
  
  has_many :payslips

  enum department: {
    computer_studies: 0,
    teacher_education: 1,
    industrial_technology: 2,
    engineering: 3,
    business_and_management: 4
  }

  enum employment_type: {
    regular: 0,
    cos: 1,
    part_time: 2
  }

  enum role: {
    human_resources: 0,
    accounting: 1,
    disbursing: 2,
    employee: 3
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  def name_initials
    splitted_full_name = full_name.split(" ")

    (splitted_full_name[0][0] + splitted_full_name[1][0]).upcase
  end
end
