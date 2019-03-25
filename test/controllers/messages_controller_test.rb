require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  test "GET new" do
    get new_message_url

    assert_response :success

    assert_select 'form' do
      assert_select 'input[type=text]'
      assert_select 'input[type=email]'
      assert_select 'textarea'
      assert_select 'input[type=submit]'
    end
  end

   # a successful post to the create_messages_url route should increase the size
    # of the ActionMailer::Base.deliveries array by 1, indicating that an email
     # was sent as a result of the action performed
  test "POST create" do
    assert_difference 'ActionMailer::Base.deliveries.size', 1 do
      post create_message_url, params: {
        message: {
          name: 'cornholio',
          email: 'cornholio@example.org',
          body: 'hai'
        }
      }
    end

    assert_redirected_to new_message_url

    follow_redirect!

    assert_match /Message received, thanks!/, response.body
  end

  test "invalid POST create" do
    post create_message_url, params: {
      message: { name: '', email: '', body: '' }
    }

    assert_match /Name .* blank/, response.body
    assert_match /Email .* blank/, response.body
    assert_match /Body .* blank/, response.body
  end

end
