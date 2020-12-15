class Task < ApplicationRecord
  validates :name, :duedate, :workload, presence: true
  belongs_to :subject, optional: true

  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events, allow_destroy: true, reject_if: proc { |att| att['title'].blank? }
  
end
