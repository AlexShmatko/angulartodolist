class Task < ActiveRecord::Base
  validates :title, presence: true,
    length: {maximum: 68}

  scope :completed, -> { where(completed: true) }
  scope :incompleted, -> { where(completed: false) }

  belongs_to :user
end
