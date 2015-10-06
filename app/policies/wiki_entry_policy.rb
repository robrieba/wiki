class WikiEntryPolicy < ApplicationPolicy

  def public
    true
  end

  def new?
    record.user_id == user.id
  end

  def edit?
    !record.private || (record.user_id == user.id) || user.admin?
  end

  def create?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  def show?
    !record.private || (record.user_id == user.id) || user.admin?
  end

end
