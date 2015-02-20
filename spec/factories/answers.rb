# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  location_id :integer
#  contact_id  :integer
#  text        :text
#  correct     :boolean          default("true"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :answer do
    
  end

end
