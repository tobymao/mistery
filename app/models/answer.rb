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
  validates_presence_of :location, :if => Proc.new {|a| a.contact.nil? && text.empty?}
  validates_presence_of :contact, :if => Proc.new {|a| a.location.nil? && a.text.empty?}
  validates_presence_of :text, allow_blank: false, :if => Proc.new {|a| a.location.nil? && a.contact.nil?}
end
