require 'rspec'
require 'hanke-henry-calendar'

describe 'Date' do
  describe '.hh' do
    context 'when passed 2012, 1, 1' do
      before :each do
        @date = Date.hh(2012, 1, 1)
      end
    
      it 'creates a Date object' do
        @date.should be_true
        @date.should be_a Date
      end
      
      describe '#jd' do
        let(:subject) { @date.jd }
        it 'returns the same value as Date.new(2012,1,1).jd' do
          subject.should == Date.new(2012,1,1).jd
        end
      end
    end
    
    context 'when more than 4 arguments are passed' do
      it 'raises ArgumentError' do
        lambda { Date.hh(2012, 1, 2, 3, 4) }.should raise_error ArgumentError
      end
    end
    
    context 'when invalid day is passed' do
      it 'raises ArgumentError' do
        lambda { Date.hh(2015, :"7", 31) }.should raise_error ArgumentError
        lambda { Date.hh(2012, 7, 31) }.should raise_error ArgumentError
        lambda { Date.hh(2015, :x, 8) }.should raise_error ArgumentError
      end
    end

    context 'when :x is passed as month for a non-Xtr year' do
      it 'raises ArgumentError' do
        lambda { Date.hh(2012, :x, 2, 3) }.should raise_error ArgumentError
      end
    end
    
    context 'when :x is passed as month for an Xtr year' do
      let(:subject) { Date.hh(2015, :x, 2, 3) }
      it 'returns a valid Date object' do
        subject.should be_true
        subject.should be_a Date
      end
    end
    
  end
  
  # Jan 1, 2012 designate the same day on both Gregorian and Hanke-Henry calendards
  describe '#hh' do
    context 'when called on Date.new(2012,1,1)' do
      let(:subject) { Date.new(2012,1,1) }
      it 'returns the same value as the Greogrian calendar counterpart' do
        subject.hh.should == '2012-1-1'
      end
    end
  end
  
  # Jan 1, 2400 on the Gregorian = Dec 31, 2399 on H-H
  describe '#hh' do
    context 'when called on Date.new(2400,1,1)' do
      let(:subject) { Date.new(2400,1,1) }
      it 'returns "2399-12-31"' do
        subject.hh.should == '2399-12-31'
      end
    end
  end
  
  # http://henry.pha.jhu.edu/calendarDir/ccctDir/ccctHTML/2015.1.html
  # Dec 31, 2015 on Gregorian = X 5, 2015
  describe '#hh' do
    context 'when called on Date.new(2015,12,31)' do
      let(:subject) { Date.new(2015,12,31) }
      it 'returns "2015-x-5"' do
        subject.hh.should == '2015-x-5'
      end
    end
  end

  describe '#xtr?' do
    context 'when called on a normal Date object with year 2012' do
      let(:subject) { Date.new(2012) }
      it 'returns false' do
        subject.xtr?.should be_false
      end
    end
    
    context 'when called on a Date object for year 2015' do
      let(:subject) { Date.hh(2015) }
      it 'returns true' do
        subject.xtr?.should be_true
      end
    end
  end
end
