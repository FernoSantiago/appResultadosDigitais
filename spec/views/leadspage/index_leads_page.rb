class IndexLeadsPageObject < BaseObject

  Capybara.current_driver = :selenium
  Capybara.app_host = 'https://app-staging.rdstation.com.br'

    def visit_page
      visit '/leads'
      self
    end

  def has_lead?(lead)
    content = find(:xpath, '//*[@id="leads-list"]')
    has_expected_fields_in_table(content, lead)
  end

  private
  def has_expected_fields_in_table(content, lead)
    content.has_content?(lead.email)
  end

  def click_on_insert_lead
    click_link I18n.t('.add-link-button')
    NewLeadsPageObject.new
  end

  def click_on_edit(email_lead)
   click_link(email_lead)
   EditLeadsSectionPageObject.new
  end

end
