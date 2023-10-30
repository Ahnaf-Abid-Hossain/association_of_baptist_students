require 'rails_helper'

RSpec.describe('users/sessions/new') do
  it 'renders the jumbotron' do
    render

    assert_select '.abs-jumbotron', count: 1
  end

  it 'renders the Sign in with Google button' do
    render
    assert_select 'a.abs-sign-in', count: 1
    assert_select '.gsi-material-button', count: 1
  end
end
