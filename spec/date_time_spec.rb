require 'rspec'
require 'hanke-henry-calendar'

describe 'DateTime' do
  describe '.hh' do
    context 'when passed 2012, 1, 2, 3, 4, 5' do
      before :each do
        @datetime = DateTime.hh(2012, 1, 2, 3, 4, 5)
      end
    
      it 'creates a DateTime object' do
        @datetime.should be_true
        @datetime.should be_a DateTime
      end
    end
    
    context 'when more than 8 arguments are passed' do
      it 'raises ArgumentError' do
        lambda { DateTime.hh(2012, 1, 2, 3, 4, 5, 6, 7, 8) }.should raise_error ArgumentError
      end
    end
    
    context 'when invalid day is passed' do
      it 'raises ArgumentError' do
        lambda { DateTime.hh(2012, 7, 31) }.should raise_error ArgumentError
        lambda { DateTime.hh(2015, :x, 8) }.should raise_error ArgumentError
      end
    end

    context 'when :x is passed as month for a non-Xtr year' do
      it 'raises ArgumentError' do
        lambda { DateTime.hh(2012, :x, 2, 3, 4, 5) }.should raise_error ArgumentError
      end
    end
    
    context 'when :x is passed as month for an Xtr year' do
      let(:subject) { DateTime.hh(2015, :x, 2, 3, 4, 5) }
      it 'returns a valid Date object' do
        subject.should be_true
        subject.should be_a DateTime
      end
    end
    
  end
  
  describe '#xtr?' do
    context 'when called on a normal DateTime object with year 2012' do
      let(:subject) { DateTime.new(2012) }
      it 'returns false' do
        subject.xtr?.should be_false
      end
    end
    
    context 'when called on a DateTime object instantiated by .hh(2012)' do
      let(:subject) { DateTime.hh(2012) }
      it 'returns false' do
        subject.xtr?.should be_false
      end
    end

    context 'when called on a DateTime object for year 2015' do
      before :each do
        @datetime = DateTime.hh(2015)
      end
      it 'returns false' do
        @datetime.hh_year.should == 2015
        @datetime.xtr?.should be_true
      end
    end
  end
end