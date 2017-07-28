class Tag < ApplicationRecord
    has_many :bar_tags
    has_many :bars, through: :bar_tags, dependent: :destroy
end
