require './caeser'

RSpec.describe Caeser do
  describe ".cipher" do
    it "ciphers the text" do
      expect(Caeser.cipher('Why did the chicken cross the road?', 13)).to eq('Jul qvq gur puvpxra pebff gur ebnq?')
    end
  end

  describe ".decipher" do
    it "deciphers the text" do
      expect(Caeser.decipher('Jul qvq gur puvpxra pebff gur ebnq?', 13)).to eq('Why did the chicken cross the road?')
    end
  end
end
