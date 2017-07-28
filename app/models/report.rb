class Report < ApplicationRecord
  belongs_to :user
  has_many :bar_reports
  has_many :bars, through: :bar_reports, dependent: :destroy
end
