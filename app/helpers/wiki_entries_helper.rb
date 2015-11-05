module WikiEntriesHelper

  def privacy_label(is_private)
    if is_private
      "Private"
    else
      "Public"
    end
 end

end
