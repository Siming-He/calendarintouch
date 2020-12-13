class Subject < ApplicationRecord
  has_many :tasks, dependent: :destroy
  
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  # validates :name, :description

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }

end
