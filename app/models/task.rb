class Task < ApplicationRecord
  belongs_to :subject, optional: true

  has_many :stages, dependent: :destroy
  
end
