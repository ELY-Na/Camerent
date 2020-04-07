class CameraPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.owner == user
  end

  def destroy?
    record.owner == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
