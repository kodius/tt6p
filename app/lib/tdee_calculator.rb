# Women BMR = 655 + (9.6 X weight in kg) + (1.8 x height in cm) – (4.7 x age in yrs)
# Men BMR = 66 + (13.7 X weight in kg) + (5 x height in cm) – (6.8 x age in yrs)

module Gender
  Man = 'man'
  Woman = 'woman'
end

module ActivityLevel
  Sedentary = 'sedentary' #Little or no Exercise/ desk job
  LightlyActive = 'lightly_active' #Light exercise/ sports 1 – 3 days/ week
  ModeratlyActive = 'moderatly_active' #Moderate Exercise, sports 3 – 5 days/ week
  VeryActive = 'very_active' #Heavy Exercise/ sports 6 – 7 days/ week TDEE
  ExtremelyActive = 'extremely_active' #Very heavy exercise/ physical job/ training 2 x/ day
end

class TDEECalculator

  def self.bmr(weight, height, age, gender)
    if gender == Gender::Man
      (665 + (9.6 * weight) + (1.8 * height) - (4.7 * age)).ceil
    elsif gender == Gender::Woman
      (66 + (13.7 * weight) + (5 * height) - (6.8 * age)).ceil
    else
      raise "Gender needs to be #{Gender::Man} or #{Gender::Woman}, sent: '#gender'"
    end
  end

  def self.tdee(weight, height, age, gender, activity_level)
    bmr = self.bmr(weight, height, age, gender)
    return bmr * get_activity_factor(activity_level)
  end

  def self.get_activity_factor(activity_level)
    if activity_level == ActivityLevel::Sedentary
      1.2
    elsif activity_level == ActivityLevel::LightlyActive
      1.375
    elsif activity_level == ActivityLevel::ModeratlyActive
      1.55
    elsif activity_level == ActivityLevel::VeryActive
      1.725
    elsif activity_level == ActivityLevel::ExtremelyActive
      1.9
    else
      raise "Usupported activity level #{activity_level}"
    end
  end

end
