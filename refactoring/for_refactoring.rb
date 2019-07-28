# Here you can find a fragment of the registration form. We want you to find
# the possible errors and suggest improvements to the code.
# It's important to consider that Wuaki is expanding into different markets all
# over the world. We would like to see an example of code refactoring.
feature 'Registrations', js: true do
  context 'with a logged user' do
    it 'allows the user to signin with success' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link 'Entrar' ### TODO use selector
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      expect(page).to have_content 'Mi videoteca' ### TODO Use constant holder for different languages
      expect(page).to have_content 'Quiero ver' ### TODO Use constant holder for different languages
    end
    it 'rents a TVOD movie' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link 'Entrar' ### TODO use selector
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      click_link 'Configuración' ### TODO use selector
      click_link 'Datos bancarios' ### TODO use selector
      expect(page).to have_content 'Tarjeta de crédito' ### TODO Use constant holder for different languages
      fill_in_bank_details_form
      within('#edit_user') { find('#user_submit').click }
      sleep 30 ### TODO replace for waiter
      expect(page).to have_content 'Los datos han sido guardados correctamente' ### TODO Use constant holder for different languages
      visit new_releases_url
      click_on_first :movie
      click_on_first_purchase_option
      sleep 10 ### TODO replace for waiter
      within('#purchase_submit_action') { click_button 'Alquilar' } ### TODO use selector
      sleep 20 ### TODO replace for waiter
      expect(page).to have_content 'Expira en' ### TODO Use constant holder for different languages
    end
    it 'is cancelled from selection' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link 'Entrar' ### TODO use selector
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      visit settings_url
      find('#main .sub-nav').click_link 'Selection' ### TODO use locator
      click_link 'Vas a darte de baja de Selection, ¿estás seguro?' ### TODO Use constant holder for different languages
      click_link 'Sí, confirmar.' ### TODO Use constant holder for different languages
      expect(page).to have_content 'Tu subscripción ha sido cancelada con éxito' ### TODO Use constant holder for different languages
    end

  end
end