class Bar < ApplicationRecord
  belongs_to :neighborhood
  has_many :photos
  has_many :bar_reports
  has_many :reports, through: :bar_reports, dependent: :destroy
  has_many :bar_tags
  has_many :tags, through: :bar_tags, dependent: :destroy
end
