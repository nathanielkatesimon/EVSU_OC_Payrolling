class ProfileControllerPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user == record
  end
end