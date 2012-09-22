require 'rspec'
require 'hanke-henry-calendar'

describe "HankeHenryDate" do
  describe '.xtr?' do
    # each cycle is 400 years, just like the Gregorian calendar, so we check
    # the first 400 years we know of.
    # see http://henry.pha.jhu.edu/calendarDir/newton.html
    it 'returns true for the correct years between 2012 and 2412' do
      (2012...2412).to_a.select { |y| HankeHenryDate.xtr?(y) }.should == 
      [
          2015,2020,2026,2032,2037,2043,2048,2054,2060,2065,2071,2076,2082,
          2088,2093,2099,2105,2111,2116,2122,2128,2133,2139,2144,2150,2156,
          2161,2167,2172,2178,2184,2189,2195,2201,2207,2212,2218,2224,2229,
          2235,2240,2246,2252,2257,2263,2268,2274,2280,2285,2291,2296,2303,
          2308,2314,2320,2325,2331,2336,2342,2348,2353,2359,2364,2370,2376,
          2381,2387,2392,2398,2404,2409
      ]
    end
  end
  
end