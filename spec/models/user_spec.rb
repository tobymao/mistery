# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string
#  email      :string
#  password   :string
#  guest      :boolean          default("false"), not null
#  admin      :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe User do
  it 'should create' do
    user = User.new
    user.login = "user1"
    user.email = "user@example.com"
    user.password = "password"
    expect(user.save).to be_truthy
  end

  context 'normal user' do
    it 'should validate login' do
      user = User.new
      user.email = "user@example.com"
      user.password = "password"
      expect(user.save).to be_falsey
    end

    it 'should validate email' do
      user = User.new
      user.login = "user1"
      user.password = "password"
      expect(user.save).to be_falsey
    end

    it 'should validate password' do
      user = User.new
      user.login = "user1"
      user.email = "user@example.com"
      expect(user.save).to be_falsey
    end
  end

  context 'guest' do
    it 'should not validate' do
      guest = User.new_guest_user
      expect(guest.save).to be_truthy
    end
  end

  describe '.password' do
    let(:user) {create(:user)}
    it {expect(user.password).to eq('password')}
  end
end
