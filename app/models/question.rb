class Question < ApplicationRecord
  has_many :answers, dependent: :destroy, inverse_of: :question

  belongs_to :category

  validates :category, presence: true
  validates :content, presence: true, length: {minimum: 10}
  validate :validate_answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :recent, ->{order created_at: :desc}

  private
  def validate_answers
    if self.answers.select{|answer| answer.is_correct?}.count < Settings.single
      errors.add :answers, I18n.t("question_admin.subject_quanlity_error")
    end
  end

end
