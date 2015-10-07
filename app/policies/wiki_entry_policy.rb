class WikiEntryPolicy < ApplicationPolicy

  def new?
    create?
  end

  def edit?
    !record.private || (record.user == user) || user.admin?
    # record.users.include?(user)
  end

  def create?
    user.present?
  end

  def destroy?
    record.user == user
  end

  def show?
    edit?
  end

end
