class CosEntriesControllerPolicy < ApplicationPolicy
  def index?
    user.human_resources?
  end

  def new?
    user.human_resources?
  end

  def create?
    user.human_resources?
  end

  def show?
    user.human_resources?
  end

  def edit?
    user.human_resources?
  end

  def update?
    user.human_resources?
  end
  
  def destroy?
    user.human_resources?
  end
end