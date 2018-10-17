require './rsa'

RSpec.describe Rsa do
  let(:rsa) { Rsa.new }

  before do
    allow_any_instance_of(Rsa).to receive(:p).and_return(11)
    allow_any_instance_of(Rsa).to receive(:q).and_return(13)
  end

  describe '#public_keys' do
    it 'should initialize n and e' do
      expect(rsa.public_keys).to eq({ e: 113, n: 143 })
    end

    it 'should initialize n and e with given keys' do
      keys = { e: 7, n: 13 }
      expect(Rsa.new(keys).public_keys).to eq(keys)
    end
  end

  describe "#cipher" do
    it "ciphers the text" do
      expect(rsa.cipher('Why did the chicken cross the road?')).to eq('120026088054133040133054051026030054099026040099061030132054099108089059059054051026030054108089080133072')
    end
  end

  describe ".decipher" do
    it "deciphers the text" do
      expect(rsa.decipher('120026088054133040133054051026030054099026040099061030132054099108089059059054051026030054108089080133072')).to eq('Why did the chicken cross the road?')
    end
  end
end
