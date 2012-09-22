require 'date'

class DateTime
  attr_accessor :hh_year, :hh_month, :hh_day
  
  ## These are the years (mod 400) that have Xtr
  XTR_YEARS = [
       4,   9,  15,  20,  26,  32,  37,  43,  48,  54,  60,  65,  71,  76,
      82,  88,  93,  99, 105, 111, 116, 122, 128, 133, 139, 144, 150, 156,
     161, 167, 172, 178, 184, 189, 195, 201, 207, 212, 218, 224, 229, 235,
     240, 246, 252, 257, 263, 268, 274, 280, 285, 291, 296, 303, 308, 314,
     320, 325, 331, 336, 342, 348, 353, 359, 364, 370, 376, 381, 387, 392,
     398
  ]
  
  ## number of days since January 1 (of Hanke-Henry year) before
  ## the first of the H-H month
  DAYS_SINCE_NEW_YEAR = {
    :"1"  =>   0,
    :"2"  =>  30,
    :"3"  =>  60,
    :"4"  =>  91,
    :"5"  => 121,
    :"6"  => 151,
    :"7"  => 182,
    :"8"  => 212,
    :"9"  => 242,
    :"10" => 273,
    :"11" => 303,
    :"12" => 333,
    :x    => 364
  }

  def self.hh(*args)
    hh_year, hh_month, hh_day, hour, minute, second = _validate(*args)
    dt = DateTime.jd _to_julian_date(hh_year, hh_month, hh_day)
    dt.hh_year  = hh_year
    dt.hh_month = hh_month
    dt.hh_day   = hh_day
    
    dt
  end
  
  # Returns true if year designated by +DateTime+ object
  # contains the Xtr week
  def xtr?
    # FIXME: it is quite possible that this method is called on an object
    # that doesn't have @hh_year
    XTR_YEARS.include? @hh_year % 400
  end
  
  private
  
  ## translate args given in Hanke-Henry calendar into Julian date,
  ## so that it can be passed to Date.jd
  def self._to_julian_date(year, month, day)
    month = month.to_s.to_sym # normalize
    
    ## Hanke-Henry and Gregorian days will sync up every 400 years
    ## Compute the number of days since the sync
    days_since_last_sync = 365 * ( year % 400 ) + _xtrs(year) * 7 +
      DAYS_SINCE_NEW_YEAR[month] + day - 1
    
    days_since_last_sync + 2451544.5 # offset for January 1, 2000
  end
  
  # Xtrs have we seen in years since year 400N
  def self._xtrs(year)
    XTR_YEARS.select { |y| y < year % 400 }.length
  end
  
  def self._validate(*args)
    if args.length > 8
      raise ArgumentError, "Too many arguments (#{args.length}) given"
    end
    
    year, month, day, hour, minute, second = args
    # defaults
    month  ||= 1
    day    ||= 1
    hour   ||= 0
    minute ||= 0
    second ||= 0
    
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
    
    if day && day > days_in_month
      raise ArgumentError, "Invalid day #{day}: only #{days_in_month} days in month #{month}"
    end
    
    [ year, month, day, hour, minute, second ]
  end
  
end
