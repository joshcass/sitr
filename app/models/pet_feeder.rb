class PetFeeder < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :url, url: true
  validates :name, uniqueness: true
end
