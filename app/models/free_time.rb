class FreeTime < ApplicationRecord
  belongs_to :user

  validates :day, :finish_at, :start_at, presence: true
  validate :time_check, :user_must_be_social_service, :check_free_time_overlap

  def time_check
    unless finish_at.nil? || start_at.nil?
      errors.add(:finish_at, "O termino precisa ser depois do começo") if finish_at <= start_at
    end
  end

  def user_must_be_social_service
    unless user.nil? || user.social_service? || user.admin?
      errors.add(:user, "Usuário deve ser do social") 
    end
  end

  def check_free_time_overlap
    ft_hash = {start: start_at, finish: finish_at}
    overlap = user.free_times.where(day: day, start_at: start_at..finish_at, finish_at: start_at...finish_at)
    errors.add(:start_at,"Horário em conflito com outro já cadastrado") unless overlap.empty?
  end

  def format_hash
    {
      day: day ? I18n.l(day) : nil,
      start_at: start_at ? start_at.strftime("%H:%M") : nil,
      finish_at: finish_at ? finish_at.strftime("%H:%M") : nil,
      user_name: user_id ? User.find(user_id).name : nil,
      user_id: user_id ? user_id : nil,
      id: id ? id : nil
    }
  end

end
