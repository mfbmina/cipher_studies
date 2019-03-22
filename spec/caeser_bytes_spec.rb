require './caeser_bytes'

RSpec.describe CaeserBytes do
  describe ".cipher" do
    it "ciphers the text" do
      expect(CaeserBytes.cipher('Why did the chicken cross the road?', 13)).to eq('Jul qvq gur puvpxra pebff gur ebnq?')
    end
  end

  describe ".decipher" do
    it "deciphers the text" do
      expect(CaeserBytes.decipher('Jul qvq gur puvpxra pebff gur ebnq?', 13)).to eq('Why did the chicken cross the road?')
    end
  end
end
