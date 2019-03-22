# frozen_string_literal: true

# pack(fmt) converts the given array into a binary sequence.
# 'c' means an 8-bit signed integer and '*' means all the array

# 65 is equal to A and 90 is equal to Z.
# 97 is equal to a and 122 is equal to z.
# anything else should not be changed

class CaeserBytes
  attr_reader :text, :rotation

  def initialize(text, rotation)
    @text = text
    @rotation = rotation
  end

  def cipher
    text.bytes.map do |byte|
      case byte
      when 65..90 then shift(byte, 65, 90)
      when 97..122 then shift(byte, 97, 122)
      else byte
      end
    end.pack('c*')
  end

  def decipher
    text.bytes.map do |byte|
      case byte
      when 65..90 then unshift(byte, 65, 90)
      when 97..122 then unshift(byte, 97, 122)
      else byte
      end
    end.pack('c*')
  end

  def self.cipher(text, rotation)
    new(text, rotation).cipher
  end

  def self.decipher(text, rotation)
    new(text, rotation).decipher
  end

  private

  def shift(byte, initial_byte, limit_byte)
    new_byte = byte + rotation
    return initial_byte - (limit_byte - new_byte) - 1 if new_byte > limit_byte
    new_byte
  end

  def unshift(byte, initial_byte, limit_byte)
    new_byte = byte - rotation
    return limit_byte - (initial_byte - new_byte) + 1 if new_byte < initial_byte
    new_byte
  end
end
