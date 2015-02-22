require 'test_helper'

class SlackerTest < Minitest::Unit::TestCase
  def setup
    @under_test = BeerBot::Slacker.new
    ENV['SLACK_TOKEN'] = 'the token'
    ENV['INCOMING_WEBHOOK_PATH'] = '/webhook'
  end

  def test_params_valid_if_token_matches
    assert @under_test.valid?({ 'token' => 'the token' })
  end

  def test_params_invalid_if_token_does_not_match
    assert !@under_test.valid?({ 'token' => 'not the token' })
  end

  def test_respond_with
    mock_response = Minitest::Mock.new
    mock_response.expect :call, { response: 'hi' } , ['result', 'params']
    BeerBot::Response.stub :new, mock_response do
      mock_client = Minitest::Mock.new
      mock_client.expect :call, nil, ['https://hooks.slack.com/services/webhook', '{"response":"hi"}']
      RestClient.stub :post, mock_client do
        @under_test.respond_with('result', 'params')
      end
    end
  end
end