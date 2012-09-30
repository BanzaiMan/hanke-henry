require 'date'

##
# This module extends Date and DateTime classes to represent the Hanke-Henry
# calendar.
#
module HankeHenryDate  
  XTR_YEARS = [
       4,   9,  15,  20,  26,  32,  37,  43,  48,  54,  60,  65,  71,  76,
      82,  88,  93,  99, 105, 111, 116, 122, 128, 133, 139, 144, 150, 156,
     161, 167, 172, 178, 184, 189, 195, 201, 207, 212, 218, 224, 229, 235,
     240, 246, 252, 257, 263, 268, 274, 280, 285, 291, 296, 303, 308, 314,
     320, 325, 331, 336, 342, 348, 353, 359, 364, 370, 376, 381, 387, 392,
     398
  ]
  
  # A 400-year cycle runs from year 1 through 400, 401 through 800, and so on.
  # N-th element in DAYS_SINCE_LAST_CYCLE is the number of days since the
  # conclusion of the previous cycle at the beginning of the year N (mod 400).
  # So, for day D, DAYS_SINCE_LAST_CYCLE.select {|d| d < D}.length indicates
  # the year mod 400.
  DAYS_SINCE_LAST_CYCLE = [
0, 364, 728, 1092, 1463, 1827, 2191, 2555, 2919, 3290, 3654, 4018, 4382, 4746,
5110, 5481, 5845, 6209, 6573, 6937, 7308, 7672, 8036, 8400, 8764, 9128, 9499,
9863, 10227, 10591, 10955, 11319, 11690, 12054, 12418, 12782, 13146, 13517,
13881, 14245, 14609, 14973, 15337, 15708, 16072, 16436, 16800, 17164, 17535,
17899, 18263, 18627, 18991, 19355, 19726, 20090, 20454, 20818, 21182, 21546,
21917, 22281, 22645, 23009, 23373, 23744, 24108, 24472, 24836, 25200, 25564,
25935, 26299, 26663, 27027, 27391, 27762, 28126, 28490, 28854, 29218, 29582,
29953, 30317, 30681, 31045, 31409, 31773, 32144, 32508, 32872, 33236, 33600,
33971, 34335, 34699, 35063, 35427, 35791, 36162, 36526, 36890, 37254, 37618,
37982, 38353, 38717, 39081, 39445, 39809, 40173, 40544, 40908, 41272, 41636,
42000, 42371, 42735, 43099, 43463, 43827, 44191, 44562, 44926, 45290, 45654,
46018, 46382, 46753, 47117, 47481, 47845, 48209, 48580, 48944, 49308, 49672,
50036, 50400, 50771, 51135, 51499, 51863, 52227, 52598, 52962, 53326, 53690,
54054, 54418, 54789, 55153, 55517, 55881, 56245, 56609, 56980, 57344, 57708,
58072, 58436, 58807, 59171, 59535, 59899, 60263, 60627, 60998, 61362, 61726,
62090, 62454, 62825, 63189, 63553, 63917, 64281, 64645, 65016, 65380, 65744,
66108, 66472, 66836, 67207, 67571, 67935, 68299, 68663, 69034, 69398, 69762,
70126, 70490, 70854, 71225, 71589, 71953, 72317, 72681, 73045, 73416, 73780,
74144, 74508, 74872, 75236, 75607, 75971, 76335, 76699, 77063, 77434, 77798,
78162, 78526, 78890, 79254, 79625, 79989, 80353, 80717, 81081, 81445, 81816,
82180, 82544, 82908, 83272, 83643, 84007, 84371, 84735, 85099, 85463, 85834,
86198, 86562, 86926, 87290, 87661, 88025, 88389, 88753, 89117, 89481, 89852,
90216, 90580, 90944, 91308, 91672, 92043, 92407, 92771, 93135, 93499, 93870,
94234, 94598, 94962, 95326, 95690, 96061, 96425, 96789, 97153, 97517, 97888,
98252, 98616, 98980, 99344, 99708, 100079, 100443, 100807, 101171, 101535,
101899, 102270, 102634, 102998, 103362, 103726, 104097, 104461, 104825, 105189,
105553, 105917, 106288, 106652, 107016, 107380, 107744, 108115, 108479, 108843,
109207, 109571, 109935, 110299, 110670, 111034, 111398, 111762, 112126, 112497,
112861, 113225, 113589, 113953, 114317, 114688, 115052, 115416, 115780, 116144,
116508, 116879, 117243, 117607, 117971, 118335, 118706, 119070, 119434, 119798,
120162, 120526, 120897, 121261, 121625, 121989, 122353, 122724, 123088, 123452,
123816, 124180, 124544, 124915, 125279, 125643, 126007, 126371, 126735, 127106,
127470, 127834, 128198, 128562, 128933, 129297, 129661, 130025, 130389, 130753,
131124, 131488, 131852, 132216, 132580, 132951, 133315, 133679, 134043, 134407,
134771, 135142, 135506, 135870, 136234, 136598, 136962, 137333, 137697, 138061,
138425, 138789, 139160, 139524, 139888, 140252, 140616, 140980, 141351, 141715,
142079, 142443, 142807, 143178, 143542, 143906, 144270, 144634, 144998, 145369,
145733
  ]
  
  DAYS_IN_COMPLETE_CYCLE = 400 * 364 + XTR_YEARS.length * 7
  
  DAYS_SINCE_NEW_YEAR = [0, 30, 60, 91, 121, 151, 182, 212, 242, 273, 303, 333, 364]
  
  HH_OFFSET = 1721423.5 # Julian date for Jan 1, 1 (on H-H calendar)

  ##
  # This module is used for extending Date and DateTime classes to include
  # class method +.hh+ that takes arguments representing Hanke-Henry calendar
  # dates and returns Date and DateTime objects.
  #
  module Module
    ##
    # 
    def hh(*args)
      hh_year, hh_month, hh_day, hour, minute, second = _validate(*args)
      DateTime.jd _to_julian_date(hh_year, hh_month, hh_day)
    end
    
    private
    
    # Xtrs have we seen in years since year 400N
    def _xtrs(year)
      XTR_YEARS.select { |y| y < year % 400 }.length
    end
    
    def _validate(*args)
      if args.length > (_hh_arg_limit || 4)
        raise ArgumentError, "Wrong number of arguments (#{args.length} for 0..#{_hh_arg_limit})"
      end
    
      year, month, day, hour, minute, second = args
    
      # defaults
      year   ||= -4712
      month  ||= 1
      day    ||= 1
      hour   ||= 0
      minute ||= 0
      second ||= 0
      months_in_year = (XTR_YEARS.include? year % 400)? 13 : 12
    
      if (month = month.to_s) == 'x'
        month = 13
      else
        month = month.to_i
      end
    
      if month == 13
        unless XTR_YEARS.include? year % 400
          raise ArgumentError, "Hanke-Henry year #{year} does not have Xtr"
        end
        days_in_month = 7
      elsif month % 3 == 0 # month is 3, 6, 9 or 12
        days_in_month = 31
      else
        days_in_month = 30
      end
      
      if day > days_in_month || day < -days_in_month || month > months_in_year ||
        month < -months_in_year || month == 0 || day == 0
        raise ArgumentError, 'invalid date'
      else
        # handle cases where month or day is negative
        month %= (months_in_year + 1)
        day   %= (days_in_month + 1)
      end
    
      [ year, month, day, hour, minute, second ]
    end
    
    ## translate args given in Hanke-Henry calendar into Julian date,
    ## so that it can be passed to Date.jd
    def _to_julian_date(year, month, day)
      ## Hanke-Henry and Gregorian days will sync up every 400 years
      complete_cycles = (year-1) / 400 # how many 400-year cycles since year 0
      years_since_last_complete_cycle = (year-1) % 400
      xtrs = _xtrs(year) # Xtrs before this year since the laste year 400N
    
      days_since_epoch = complete_cycles * DAYS_IN_COMPLETE_CYCLE +
        years_since_last_complete_cycle * 364 +
        xtrs * 7 +
        DAYS_SINCE_NEW_YEAR[month - 1] +
        day + 1

      days_since_epoch + HH_OFFSET
    end

  end

  ##
  # +#xtr?+ returns true if the +DateTime+ object falls in a Hanke-Henry year
  # which contains the Xtr week.
  #
  def xtr?
    XTR_YEARS.include?((_from_julian_date(self.jd)[0]) % 400)
  end
  
  ##
  # +hh+ returns a string representation of the Hanke-Henry date.
  #
  def hh
    "%d-%0s-%0d" % _from_julian_date(self.jd)
  end
  
  private
  
  # given Julian date jd, compute H-H date
  def _from_julian_date(jd)
    year = (jd - HH_OFFSET).floor / DAYS_IN_COMPLETE_CYCLE * 400
    day  = (jd - HH_OFFSET).floor % DAYS_IN_COMPLETE_CYCLE # remainining days
    
    remainder_years = DAYS_SINCE_LAST_CYCLE.select { |d| d < day }.length
    year += remainder_years
    
    day -= DAYS_SINCE_LAST_CYCLE[year % 400 - 1]
    
    days_in_month = [0, 30, 60, 91, 121, 151, 182, 212, 242, 273, 303, 333]
    if XTR_YEARS.include? remainder_years % 400
      days_in_month << 364
    end
    
    month = days_in_month.select { |d| d < day }.length
    day -= days_in_month[month - 1]
    
    if month == 13
      month = :x
    end
    
    [year, month, day]
  end
  
  
end
