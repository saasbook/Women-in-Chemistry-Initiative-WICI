class Assignment < ApplicationRecord
  belongs_to :volunteer
  belongs_to :task

  def name
    self.volunteer.name
  end
end
