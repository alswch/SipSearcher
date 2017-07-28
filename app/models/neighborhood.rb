class Neighborhood < ApplicationRecord
    has_many :bars
    validates :neighborhood_name, :uniqueness => true, :presence => { :message => "This neighborhood already exists." }
end
