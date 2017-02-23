class EditLeadsPageObject < BaseObject

  def click_on_edit
    click_on 'Editar'
    EditLeadsSectionPageObject.new
  end

  def change_field(id, value)
    find(id).set(value)
  end

  def click_on_save
    click_on 'Salvar'
  end

  def has_content(message)
    has_content?(message)
  end

  def has_message?(message)
    has_content?(message)
  end

  def click_on_remove
    click_link I18n.t('.exclude-lead-link')
  end

end
