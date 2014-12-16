require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "observer_ticket" do
    mail = UserMailer.observer_ticket
    assert_equal "Observer ticket", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
