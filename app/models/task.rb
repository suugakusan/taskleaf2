class Task < ApplicationRecord
    before_validation :set_nameless_name
    scope :recent, -> { order(created_at: :desc) }
    validates :name, presence: true, length: { maximum: 30 }
    validate :validate_name_not_including_conma
    belongs_to :user

    private

    def validate_name_not_including_conma
        errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
    end

    def set_nameless_name
        self.name = "名前なし" if name.blank?
    end
end
