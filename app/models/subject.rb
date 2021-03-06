class Subject < ApplicationRecord
  validates :name, :description, presence: true
  validates :name, uniqueness: true

  has_many :tasks, dependent: :destroy
  
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }

  has_one_attached :syllabus

  def user_add=(user)
    Registration.create({ subject: Subject.find(id), user: user })
  end

  def user_drop=(user)
    if !Registration.where(user_id: user.id).find_by(subject_id: id).nil?
      Registration.where(user_id: user.id).find_by(subject_id: id).destroy
    end
  end

  def get_users
    subject = Subject.find(id)
    subject.users.to_a
  end
end
