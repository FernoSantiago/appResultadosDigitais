class LoginPageObject < BaseObject

Capybara.current_driver = :selenium
Capybara.app_host = 'https://app-staging.rdstation.com.br'

  def visit_page
    visit '/login'
    self
  end

  def login(user)
    within("#login-form") do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.senha
    end
    click_button 'Entrar'
  end
end
