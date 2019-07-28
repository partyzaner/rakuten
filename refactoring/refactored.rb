# frozen_string_literal: true

require 'i18n'

I18n.load_path << Dir[File.expand_path("refactoring/locales") + "/*.yml"]
I18n.default_locale = :es

###
# Note: some translated elements can be changed to element locators
# Sleeps not changed to waiters (Not able to see source code of pages)
###

feature 'Registrations', js: true do
  context 'with a logged user' do
    it 'allows the user to signin with success' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link I18n.t(:enter)
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      expect(page).to have_content I18n.t(:my_video_library)
      expect(page).to have_content I18n.t(:want_see)
    end
    it 'rents a TVOD movie' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link I18n.t(:enter)
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      click_link I18n.t(:configuration)
      click_link I18n.t(:bank_data)
      expect(page).to have_content I18n.t(:credit_card)
      fill_in_bank_details_form
      find('#edit_user #user_submit').click
      sleep 30 ### TODO replace for waiter of page specific element
      expect(page).to have_content I18n.t(:data_saved)
      visit new_releases_url
      click_on_first :movie
      click_on_first_purchase_option
      sleep 10 ### TODO replace for waiter of page specific element
      within('#purchase_submit_action') { click_button I18n.t(:rent) }
      sleep 20 ### TODO replace for waiter of page specific element
      expect(page).to have_content I18n.t(:expires_in)
    end
    it 'is cancelled from selection' do
      timestamp = Time.now.strftime '%Y%m%d-%H%M%S'
      email = "#{timestamp}@wuaki.tv"
      visit '/'
      click_link I18n.t(:enter)
      expect(current_url).to eq(sign_in_url)
      fill_in_sign_in_form email
      visit settings_url
      find('#main .sub-nav').click_link I18n.t(:selection)
      click_link I18n(:unsubscribe_question)
      click_link I18n.t(:confirm)
      expect(page).to have_content I18n.t(:cancel_subscription)
    end

  end
end