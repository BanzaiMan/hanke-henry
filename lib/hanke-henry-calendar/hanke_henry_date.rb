class HankeHenryDate < Date
  def initialize(*args)
    
  end
  
  # Retruns self
  def hhdate
    self
  end
  
  def now
    
  end
  
  # HankeHenryDate.xtr?(year)
  # returns true if year contains the 'Xtr' mini-month
  def self.xtr?(year)
    _xtr(year)
  end
  
  private
  def self._xtr(year)    
    x = false
    [year - 1, year].each do |i|
      idays = i*365 + i/4 - i/100 + i/400
      nweeks = idays/7
      iremainder = idays - nweeks * 7
      if (iremainder == 4 && i == year) || (iremainder == 3 && i == year - 1)
        x = true
      end
    end
    x
  end
end