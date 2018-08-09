#ovo je pretesko za mene :)
#https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3975626/
class WeightPrediction

  def self.predict(gender, fat_mass, day_number, height, baseline_age )
    if gender == 'man'
      result = -72.1 + 2.5*fat_mass - 0.04*(baseline_age + day_number/365)
       + 0.7*height - 0.002*(baseline_age + day_number/365) - 0.01*height - 0.04*(day_number^2)
       + 0.0003*(day_number^2)*(baseline_age + day_number/365)
       + 0.0000004*(day_number^4) + 0.0002*(day_number^3) + 0.0003*(day_number^2)*height - 0.000002*(day_number^3)*height
    elsif gender == 'woman'
      # −71.7 + 3.6*fat_mass − 0.04(baseline_age + day_number ∕ 365) + 0.7*height
      # − 0.002*(baseline_age + day_number ∕ 365) − 0.01*height
      # + 0.00003*(day_number^2)*(baseline_age + day_number ∕ 365) − 0.07*(day_number^2)
      # + 0.0006(day_number)^3 − 0.000002*(day_number^4) + 0.0003*(day_number^2)*height - 0.000002*(day_number^3)*height
    else
      raise "Unsupported gender #{gender}"
    end
  end

end
