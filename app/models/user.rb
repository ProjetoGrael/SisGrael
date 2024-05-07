class User < ApplicationRecord
  has_one :teacher, class_name: 'Academic::Teacher', dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :free_times

  validates :name, presence: true, length: {in: 3..100}
  has_many :interviews
  has_many :vocational_interviews
  has_many :occurrences

  enum kind: {
    standard: 0,
    admin: 1,
    secretary: 2,
    instructor: 3,
    pedagogue: 4,
    social_service: 5,
    coordination: 6,
    administration: 7,
    financial: 8
  }

  mount_uploader :picture, PictureUploader
  mount_uploader :signature, PictureUploader

  
  
end
