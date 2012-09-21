# Hanke-Henry Calendar

`hanke-henry-calender` is a gem that deals with the proposed
[Hanke-Henry Calendar][1].
This calendar has the following preferable characteristics over
the presently adopted Gregorian Calendar:

1. No time zones.
1. No Daylight Savings Time.
1. Dates will fall on the same weekday.

`hanke-henry-calendar` extends the Date class to deal with this
calendar.

## Installation

Add this line to your application's Gemfile:

    gem 'hanke-henry-calendar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanke-henry-calendar

## Usage

    require 'date'
    require 'hanke-henry-calendar'
    
    now = Date.now # => 
    now.hhyear     # => 
    now.hhmonth    # =>
    now.hhday      # => 
    
    hhnow = HankeHenryDate.now # =>
    hhnow.year     # => year in Gregorian calendar
    hhnow.hhyear   # =>
    
    hhtime = HankeHenryDate.new(2012, 1, 1, 0, 0) # given in Hanke-Henry calendar date
    hhtime.hhyear  # => 2012
    

## Contributing
By contributing, you certify that you have full legal rights to your
contribution and agree that it can be redistributed under the license
described in `LICENSE.txt`.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: http://henry.pha.jhu.edu/calendar.html