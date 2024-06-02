class PayrollsControllerPolicy < ApplicationPolicy
  def index?
    !user.employee?
  end

  def new?
    user.human_resources?
  end

  def ada?
    !user.employee?
  end

  def create?
    user.human_resources?
  end

  def show?
    !user.employee?
  end

  def edit?
    user.human_resources?
  end

  def update?
    !user.employee?
  end
  
  def destroy?
    user.human_resources?
  end
end