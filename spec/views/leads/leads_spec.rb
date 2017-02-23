require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Leads Integration Tests", :type => :feature do

  let(:user) { create(:user, email: 'scambaw@gmail.com', senha: 'Super!') }
  let(:login_page) { LoginPageObject.new }
  let(:index_page) { IndexLeadsPageObject.new }
  let(:edit_page) { EditLeadsPageObject.new }

  context '#valid_user' do

    before :each do
      login_page.visit_page.login(user)
    end

    context 'List Leads' do
      let!(:lead) { create(:lead, email: 'ferno01@ferno01.com.br') }
      it "Render the Lists of Leads" do
        index_lead_page.visit_page
        expect(index_lead_page).to have_lead(lead)
      end
    end

    it 'Click on New' do
      index_lead_page.visit_page
      new_lead_page = index_lead_page.click_on_insert_lead
      expect(new_lead_page).to have_current_path(new_admin_lead_path)
    end

    context "Create a Lead" do
      let(:new_lead) { build(:lead, email: 'ferno02@ferno02.com.br') }

      before {
        index_lead_page.visit_page
      }

      it 'Creates a valid lead' do
       new_lead_page = index_lead_page.click_on_insert_lead
       new_lead_page.fill_in_with_lead(new_lead)
       edit_lead_page = new_lead_page.click_on_save #edit_lead_page == form
       expect(edit_lead_page).to have_content(new_lead)
     end

     it 'Create with invalid value' do
        new_lead_page = index_lead_page.click_on_insert_lead
        new_lead_page.fill_in_with_lead(new_lead)
        new_lead_page.make_blank_field('#lead_email')
        new_lead_page.click_on_save
        expect(new_lead_page).to have_message('Não foi possível criar o Lead, por favor verifique os campos')
      end
    end

    context "Editing a Lead" do
      let!(:lead) { create(:lead, email: 'ferno03@ferno03.com.br') }

      before {
        index_lead_page.visit_page
      }

      it 'Edit the lead with success' do
        edit_lead_page = index_lead_page.click_on_edit('ferno02@ferno02.com.br')
        edit_lead_section_page = edit_lead_page.click_on_edit
        edit_lead_section_page.change_field('#inputEmail', lead)
        edit_lead_page = edit_lead_section_page.click_on_save
        expect(edit_lead_page).to have_message('Lead atualizado com sucesso.')
      end

      it 'Edit with invalid value' do
        edit_lead_page = index_lead_page.click_on_edit('ferno02@ferno02.com.br')
        edit_lead_page.change_field('#lead_email', '')
        edit_lead_page.click_on_save
        expect(edit_lead_page).to have_invalid_message_on_div('Não foi possível atualizar o Lead.')
      end
    end

    context "Remove lead" do
      let!(:lead) { create(:lead, email: 'ferno02@ferno02.com.br') }

      before {
        index_lead_page.visit_page
      }

      it 'Remove the lead' do
        edit_lead_page = index_lead_page.click_on_edit('ferno02@ferno02.com.br')
        index_lead_page = edit_lead_page.click_on_remove
        expect(index_lead_page).to have_message('Lead excluído!')
      end
    end
  end
end
