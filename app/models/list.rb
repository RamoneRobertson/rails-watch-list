class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy, strict_loading: true
  has_many :movies, through: :bookmarks, strict_loading: true
  # list.rb
  has_one_attached :photo

  validates :name, presence: true
  validates :name, uniqueness: true
end
