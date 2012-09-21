require 'rspec'
require 'hanke-henry-calendar'

describe "HankeHenryDate" do
  context "when instantiated with #new(2012, 1, 2)" do
    let(:hhdate) { HankeHenryDate.new(2012, 1, 2) }
    
    describe "#hhdate" do
      it "returns self" do
        hhdate.hhdate.should === hhdate
      end
    end
    
    describe "#hhyear" do
    end
  end
  
end