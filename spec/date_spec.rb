require 'rspec'
require 'hanke-henry-calendar'

describe 'Date' do
  describe '.hh' do
    context 'when passed 2012' do
      let(:subject) { Date.hh(2012) }
      it 'should return a valid object' do
        subject.should be_true
      end
    end
    
    context 'when passed (2015, "x", 1)' do
      let(:subject) { Date.hh(2015, "x", 1) }
      it 'returns a valid object' do
        subject.should be_true
      end
    end
  end
  
  context 'when instantiated with #new(2012, 1, 31)' do
    let(:d) { Date.new(2012, 1, 31) }
    # In HH calendar, it is Feb 1, 2012
    describe '#hhyear' do
      it 'returns 2012' do
        d.hhyear.should == 2012
      end
    end
    
    describe '#hhmonth' do
      it 'returns 2' do
        d.hhmonth.should == 2
      end
    end
    
    describe '#hhday' do
      it 'returns 1' do
        d.hhday.should == 1
      end
    end
  end
  
  context 'when instantiated with #new(2012, 2, 29)' do
    let(:d) { Date.new(2012, 2, 29) }
    # In HH calendar, it is Feb 30, 2012
    describe '#hhyear' do
      it 'returns 2012' do
        d.hhyear.should == 2012
      end
    end
    
    describe '#hhmonth' do
      it 'returns 2' do
        d.hhmonth.should == 2
      end
    end
    
    describe '#hhday' do
      it 'returns 30' do
        d.hhday.should == 30
      end
    end
  end

end