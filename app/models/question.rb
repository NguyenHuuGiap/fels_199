class Question < ApplicationRecord
  has_many :answers, dependent: :destroy, inverse_of: :question

  belongs_to :category

  validates :category, presence: true
  validates :content, presence: true, length: {minimum: 10}

  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :recent, ->{order created_at: :desc}

  def validate_answers?
    self.answers.select{|answer| answer.is_correct?}.count >= Settings.single
  end

end
