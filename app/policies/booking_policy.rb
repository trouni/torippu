class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.passenger == user
  end

  def update?
    true
  end  
  
  def destroy?
    record.passenger == user
  end
end
