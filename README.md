# Hanke-Henry Calendar

`hanke-henry-calender` is a gem that deals with the proposed
[Hanke-Henry Calendar][1].
This calendar has the following preferable characteristics over
the presently adopted Gregorian Calendar:

1. Calendar remains identical year after year.
1. No time zones.
1. No Daylight Savings Time.

The typical year in the current Gregorian calendar has 365 days, which is 52
weeks and 1 day.
The leap years occur every 4 years (with some exceptions).
The basic idea of the Hanke-Henry calendar is to gather the overflow days of the
typical year and the leap days and into chunks of 7, which will
form a mini-month (called _Xtr_) at the end of the year every so often.
This will allow consistent number of days in each month year after year,
except those in _Xtrs_.

The H-H calendar also proposes to abolish time zones and Daylight Savings Time,
essentially standardizing on the current UTC.

`hanke-henry-calendar` extends the Date and DateTime classes to deal with this
calendar.



## Installation

Add this line to your application's Gemfile:

    gem 'hanke-henry-calendar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanke-henry-calendar

## Usage

    require 'hanke-henry-calendar' # requires 'date' as well

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