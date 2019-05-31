class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.trip.end_time < Time.now && (record.trip.users.include?(user) || record.trip.driver)
  end
end
