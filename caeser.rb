# frozen_string_literal: true

# make the text downcase just to keep it simple
# letters must be changed, symbols not.

class Caeser
  attr_reader :text, :rotation

  def initialize(text, rotation)
    @text = text.downcase
    @rotation = rotation
  end

  def cipher
    text
      .chars
      .map { |letter| cipher_alphabet[letter] || letter }
      .join
  end

  def decipher
    text
      .chars
      .map { |letter| decipher_alphabet[letter] || letter }
      .join
  end

  def self.cipher(text, rotation)
    new(text, rotation).cipher
  end

  def self.decipher(text, rotation)
    new(text, rotation).decipher
  end

  private

  def cipher_alphabet
    return @cipher_alphabet unless @cipher_alphabet.nil?

    @cipher_alphabet = {}

    ('a'..'z').each_with_index do |v, i|
      index = i + rotation
      index -= 26 if index > 25

      @cipher_alphabet[v] = ('a'..'z').to_a[index]
    end

    @cipher_alphabet
  end

  def decipher_alphabet
    @decipher_alphabet ||= cipher_alphabet.invert
  end
end
