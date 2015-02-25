# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  ip_address :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_token    (token) UNIQUE
#  index_sessions_on_user_id  (user_id)
#

require 'rails_helper'

describe Session do
  let(:user) {create(:user)}

  it 'should create' do
    session = Session.new
    session.token = "session1"
    session.ip_address = "127.0.0.1"
    session.user = user
    expect(session.save).to be_truthy
  end

  it 'should validate token' do
    session = Session.new
    session.ip_address = "127.0.0.1"
    session.user = user
    expect(session.save).to be_falsey
  end

  it 'should validate ip' do
    session = Session.new
    session.token = "session1"
    session.user = user
    expect(session.save).to be_falsey
  end

  it 'should validate user' do
    session = Session.new
    session.token = "session1"
    session.ip_address = "127.0.0.1"
    expect(session.save).to be_falsey
  end
end
