require 'cgi'
require 'oj'
module YolCommon

  def test(name)
    name
  end 

  def test1(name)
    name
  end 

  # 重复范围： 支持日期/数字等所有格式
  def duplicate_periods(periods)
    duplicate_periods = []
    periods.each do |a|
      a_index = periods.index(a)
      temp_periods = periods.clone
      temp_periods.delete_at(a_index)
      temp_periods.each do |b|
        result = a & b
        duplicate_periods << result if result
      end
    end
    duplicate_periods.uniq
  end

  # 计算量日期间的工作日
  def business_days_between(date1, date2)
    business_days = 0
    date = date2
    while date > date1
     business_days = business_days + 1 unless date.saturday? or date.sunday?
     date = date - 1.day
    end
    business_days
  end

end
