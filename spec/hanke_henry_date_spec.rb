require 'rspec'
require 'hanke-henry-calendar'

class HHDate < Date
  extend HankeHenryDate::Module
  include HankeHenryDate
  
  private
  def self._hh_arg_limit
    4
  end
end

describe 'HHDate' do
  describe '.hh' do
    context 'valid parameters are passed' do
      it 'does not raise error' do
        HHDate.hh(2012,   1,  1).should be_a Date
        HHDate.hh(2015, -13,  1).should be_a Date
        HHDate.hh(2012,   1,  1).should_not be_a DateTime
      end
    end
    
    context 'when passed 2012, 1, 1' do
      before :each do
        @date = HHDate.hh(2012, 1, 1)
      end
      
      describe '#jd' do
        let(:subject) { @date.jd }
        it 'returns the same value as Date.new(2012,1,1).jd' do
          subject.should == Date.new(2012,1,1).jd
        end
      end
    end
    
    context 'when passed 2012, 1, -1' do
      before :each do
        @date = HHDate.hh(2012, 1, -1)
      end
    
      describe '#jd' do
        let(:subject) { @date.jd }
        it 'returns the same value as HHDate.new(2012,1,30)' do
          subject.should == HHDate.new(2012,1,30).jd
        end
      end
    end
    
    context 'when more than 4 arguments are passed' do
      it 'raises ArgumentError' do
        lambda { HHDate.hh(2012, 1, 2, 3, 4) }.should raise_error ArgumentError
      end
    end
    
    context 'when argument limit is altered' do
      it 'respects the new limit' do
        class HHDate
          private
          def self._hh_arg_limit
            8
          end
        end
        lambda { HHDate.hh(2012, 1, 2, 3, 4, 5, 6, 7, 8) }.should raise_error ArgumentError
        
        class HHDate2 < HHDate
          private
          def self._hh_arg_limit
            5
          end
        end
        lambda { HHDate2.hh(2012, 1, 2, 3, 4, 5) }.should raise_error ArgumentError
      end
    end
    
    context 'when invalid day is passed' do
      it 'raises ArgumentError' do
        lambda { HHDate.hh(2015, :"7", 31) }.should raise_error ArgumentError
        lambda { HHDate.hh(2012,    7, 31) }.should raise_error ArgumentError
        lambda { HHDate.hh(2012,    1, 31) }.should raise_error ArgumentError
        lambda { HHDate.hh(2012,  -13,  1) }.should raise_error ArgumentError
        lambda { HHDate.hh(2015,   :x,  8) }.should raise_error ArgumentError
        lambda { HHDate.hh(2012,    0,  8) }.should raise_error ArgumentError
        lambda { HHDate.hh(2012,    1,  0) }.should raise_error ArgumentError
      end
    end

    context 'when :x is passed as month for a non-Xtr year' do
      it 'raises ArgumentError' do
        lambda { HHDate.hh(2012, :x, 2, 3) }.should raise_error ArgumentError
      end
    end
    
    context 'when :x is passed as month for an Xtr year' do
      let(:subject) { HHDate.hh(2015, :x, 2, 3) }
      it 'returns a valid Date object' do
        subject.should be_true
        subject.should be_a Date
      end
    end
    
  end
  
  # Jan 1, 2012 designate the same day on both Gregorian and Hanke-Henry calendards
  describe '#hh' do
    context 'when called on HHDate.new(2012,1,1)' do
      let(:subject) { HHDate.new(2012,1,1) }
      it 'returns the same value as the Greogrian calendar counterpart' do
        subject.hh.should == '2012-1-1'
      end
    end
  end
  
  # Jan 1, 2400 on the Gregorian = Dec 31, 2399 on H-H
  describe '#hh' do
    context 'when called on HHDate.new(2400,1,1)' do
      let(:subject) { HHDate.new(2400,1,1) }
      it 'returns "2399-12-31"' do
        subject.hh.should == '2399-12-31'
      end
    end
  end
  
  # http://henry.pha.jhu.edu/calendarDir/ccctDir/ccctHTML/2015.1.html
  # Dec 31, 2015 on Gregorian = X 5, 2015
  describe '#hh' do
    context 'when called on HHDate.new(2015,12,31)' do
      let(:subject) { HHDate.new(2015,12,31) }
      it 'returns "2015-x-5"' do
        subject.hh.should == '2015-x-5'
      end
    end
  end

  describe '#xtr?' do
    context 'when called on a normal HHDate object with year 2012' do
      let(:subject) { HHDate.new(2012) }
      it 'returns false' do
        subject.xtr?.should be_false
      end
    end
    
    context 'when called on a HHDate object for year 2015' do
      let(:subject) { HHDate.hh(2015) }
      it 'returns true' do
        subject.xtr?.should be_true
      end
    end
  end
end

class HHDateTime < DateTime
  extend HankeHenryDate::Module
  include HankeHenryDate
  
  private
  def self._hh_arg_limit
    8
  end
end

describe 'HHDateTime' do
  describe '.hh' do
    context 'valid parameters are passed' do
      it 'does not raise error' do
        HHDateTime.hh(2012,   1,  1).should be_a DateTime
        HHDateTime.hh(2015, -13,  1).should be_a DateTime
      end
    end
  end
end
