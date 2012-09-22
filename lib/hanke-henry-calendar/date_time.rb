require 'date'

class DateTime
  attr_accessor :hh_year, :hh_month, :hh_day, :hh_hour, :hh_minute, :hh_second
  def self.hh(*args)
    _normalize(*args) # 
    
    dt = DateTime.new(args.to_gregorian)
  end
  
  def to_s
    
  end
  
  # Returns true if year designated by +DateTime+ object
  # contains the Xtr week
  def xtr?
    ::HankeHenryDate.xtr?(@hh_year)
  end
  
  private
  
  ## translate args given in Hanke-Henry calendar into Gregorian
  def self._normalize(*args)
    valid_args = _validate(*args)
    
  end
  
  def self._validate(*args)
    if args.length > 6
      raise ArgumentError, "Too many arguments (#{args.length}) given"
    end
    
    year, month, day, hour, minute, second = args
    
    if month
      if month.to_s.to_sym == :x
        days_in_month = 7
        unless ::HankeHenryDate.xtr?(year)
          raise ArgumentError, "Hanke-Henry year #{year} does not have Xtr"
        end
      elsif month % 3 == 0 # month is 3, 6, 9 or 12
        days_in_month = 31
      else
        days_in_month = 30
      end
    end
    
    if day && day > days_in_month
      raise ArgumentError, "Invalid day #{day}: only #{days_in_month} days in month #{month}"
    end
    
    args
  end
  
end