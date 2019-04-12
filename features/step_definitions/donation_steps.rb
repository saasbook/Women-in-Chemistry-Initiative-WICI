And /I donate \$(.*)/ do |amount|
  fill_in 'amount_dollars', with: amount
  click_button 'donate'
end

And /I authorize payment/ do
  click_button 'confirm'
  stripe_iframe = all('iframe[name=stripe_checkout_app]').last
  Capybara.within_frame stripe_iframe do
    page.execute_script(%Q{ $('input#email').val('walker.spence@gmail.com'); })
    page.execute_script(%Q{ $('input#card_number').val('4242424242424242'); })
    page.execute_script(%Q{ $('input#cc-exp').val('08/44'); })
    page.execute_script(%Q{ $('input#cc-csc').val('999'); })
    page.execute_script(%Q{ $('#submitButton').click(); })
    sleep(3) # allows stripe_checkout_app to submit
  end
end