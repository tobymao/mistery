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

class Answer < ActiveRecord::Base
  belongs_to :question, inverse_of: :answers
  belongs_to :location
  belongs_to :contact

  validates_presence_of :question_id
  validates_presence_of :location, :if => lambda {|a| a.contact.nil? && text.nil?}
  validates_presence_of :contact, :if => lambda {|a| a.location.nil? && a.text.nil?}
  validates_presence_of :text, allow_blank: false, :if => lambda {|a| a.location.nil? && a.contact.nil?}

  def text=(new_text)
    super(new_text) if new_text.present? && new_text.strip.present?
  end
end
