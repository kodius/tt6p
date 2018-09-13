class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :normalize_keys!

  def index
    render template: 'application'
  end

  def normalize_keys!(val = params)
    if val.class == Array
      val.map { |v| normalize_keys! v }
    else
      if val.respond_to?(:keys)
        val.keys.each do |k|
          current_key_value = val[k]
          val.delete k
          val[k.to_s.underscore] = normalize_keys!(current_key_value)
        end
      end
      val
    end
    val
  end

end
