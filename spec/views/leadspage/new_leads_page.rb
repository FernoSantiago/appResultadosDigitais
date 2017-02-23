class NewLeadsPageObject < BaseObject

  def has_current_path?(path)
      current_path == path
  end

  def fill_in_with_lead(lead)
    find("#lead_email").set(lead.email)
  end

  def click_on_save
    click_on 'Salvar'
    EditLeadsPageObject.new
  end

  def has_message?(message)
    has_content?(message)
  end

  def make_blank_field(field)
    find(field).set('')
  end

end
