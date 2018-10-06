class Awards
    # STRONGMAN
    # LONEGEST STREAK
    # MOST FAT LOST
    # MOST BF% LOST
    # LOWEST BF%

    def self.get_all
      result = {}
      active_user_ids = Measurement.select("user_id").group(:user_id).having("MAX(log_date) >= ?", DateTime.now - 1.month).pluck(:user_id)
      plans = Plan.where("user_id in (?)", active_user_ids)
      plans.each do |plan|
        result[plan.id] = []
      end
      if plans.count > 0
        strongman = plans.sort_by { |p| p.last_lean_body_mass }.last
        longest_streak = plans.sort_by { |p| p.days_streak }.last
        most_fat_lost = plans.sort_by { |p| p.fat_lost }.last
        most_bf_lost_percent = plans.sort_by { |p| (p.body_fat - p.last_body_fat) }.last
        lowest_bf_percent = plans.sort_by { |p| p.last_body_fat }.first
        result[strongman.id] = result[strongman.id]  << "STRONGMAN"
        result[longest_streak.id] = result[longest_streak.id]  << "LONGEST STREAK"
        result[most_fat_lost.id] = result[most_fat_lost.id]  << "MOST FAT LOST"
        result[most_bf_lost_percent.id] = result[most_bf_lost_percent.id]  << "MOST BF% LOST"
        result[lowest_bf_percent.id] = result[lowest_bf_percent.id]  << "LOWEST BF%"
      end
      return result
    end
end