class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  class User < Scope
    def resolve
      user.trips
    end
  end

  def show?
    true
  end
end
