[![Build Status](https://secure.travis-ci.org/BanzaiMan/hanke-henry-calendar.png)](http://travis-ci.org/BanzaiMan/hanke-henry-calendar)

# Hanke-Henry Calendar

`hanke-henry` is a gem that deals with the proposed
[Hanke-Henry Calendar][1].
This calendar has the following characteristics over
the presently adopted Gregorian Calendar:

1. Calendar remains identical for the most part.
1. No time zones.
1. No Daylight Savings Time.

The typical year in the current Gregorian calendar has 365 days, which is 52
weeks and 1 day.
The leap years occur every 4 years (with some exceptions).
The basic idea of the Hanke-Henry calendar is to gather the overflow days of
the typical year and the leap days and into chunks of 7, which will form a
mini-month (called _Xtr_) at the end of the year every so often.

The H-H calendar also proposes to abolish time zones and Daylight Savings Time,
essentially standardizing on the current UTC.

`hanke-henry-calendar` extends the Date and DateTime classes to deal with this
calendar.

## Installation

Add this line to your application's Gemfile:

    gem 'hanke-henry'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanke-henry

## Usage

    require 'hanke-henry' # requires 'date' as well
    d1 = Date.hh(2012, 1, 1) # => #<Date: 2012-01-01 ((2455928j,0s,0n),+0s,2299161j)>
    d1.hh # => "2012-1-1"
    d1.xtr? # => false
    d2 = Date.hh(2015, :x, 5) # => #<Date: 2015-12-31 ((2457388j,43200s,0n),+0s,2299161j)>
    d2.xtr? # => true

## Contributing
By contributing, you certify that you have full legal rights to your
contribution and agree that it can be redistributed under the license
described in `LICENSE.txt`.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Development
    git clone git://github.com/BanzaiMan/hanke-henry-calendar.git
    cd hanke-henry-calendar
    bundle install
    bundle exec autotest

[1]: http://henry.pha.jhu.edu/calendar.html