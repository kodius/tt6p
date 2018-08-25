class Awards
    # FATFUCK
    # STRONGMAN
    # LONEGEST STREAK
    # MOST FAT LOST
    # MOST BF% LOST
    def self.get_all
        result = {}
        Plan.all.each do |plan|
            result[plan.id] = []
        end
        plans = Plan.all
        fat_fuck = plans.sort_by { |p| p.last_body_fat }.first
        strongman = plans.sort_by { |p| p.last_lean_body_mass }.first
        longest_streak = plans.sort_by { |p| p.days_streak }.first
        most_fat_lost = plans.sort_by { |p| (p.body_fat - p.last_body_fat) }.first
        most_bf_lost_percent = plans.sort_by { |p| p.days_streak }.first
        result[fat_fuck.id] = result[fat_fuck.id]  << "FAT FUCK"
        result[strongman.id] = result[strongman.id]  << "STRONGMAN"
        result[longest_streak.id] = result[longest_streak.id]  << "LONEGEST STREAK"
        result[most_fat_lost.id] = result[most_fat_lost.id]  << "MOST FAT LOST"
        result[most_bf_lost_percent.id] = result[most_bf_lost_percent.id]  << "MOST BF% LOST"
        return result
    end
end