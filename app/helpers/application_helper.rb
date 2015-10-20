module ApplicationHelper

  def account_type_label
    if current_user.premium?
      "Premium"
    else
      "Standard"
    end
  end

end
