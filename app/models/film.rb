class Film < ApplicationRecord
    GENRES = %w[action comedy drama horror romance thriller sci-fi fantasty animation documentary musical western].freeze
    
    has_many :comments, as: :commentable, dependent: :destroy

    validates :release_year, presence: true
    validates :release_year, numericality: true
    validates :description, length: {minimum: 10}
    validates :release_year, numericality: {greater_than_or_equal_to: 2024} 
    validates :release_year, numericality: { less_than_or_equal_to: 2027 }
    validates :duration, numericality: {greater_than_or_equal_to: 90, less_than_or_equal_to: 240 }
    validates :name, presence: true, uniqueness: { scope: :release_year }
    validate :genres_validations 
    private 
    def genres_validations
        
        unless genres.is_a?(Array) && genres.any?{|genre|genre.present?}
        errors.add("genres","invalid")
        end
    end
end
