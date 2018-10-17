require 'prime'

class Rsa
  def initialize(keys = {})
    @e ||= keys[:e]
    @n ||= keys[:n]
  end

  def cipher(message)
    message.bytes.map do |byte|
      cbyte = ((byte.to_i ** e) % n).to_s
      missing_chars = n.to_s.size - cbyte.size
      '0' * missing_chars + cbyte
    end.join
  end

  def decipher(ciphed_message)
    ciphed_message.chars.each_slice(n.to_s.size).map do |arr|
      (arr.join.to_i ** d) % n
    end.pack('c*')
  end

  def public_keys
    { n: n, e: e }
  end

  private

  def p
    @p ||= random_prime_number
  end

  def q
    @q ||= random_prime_number
  end

  def n
    @n ||= p * q
  end

  def totient
    @totient ||= (p - 1) * (q - 1)
  end

  def e
    @e ||= totient.downto(2).find do |i|
      Prime.prime?(i) && totient % i != 0
    end
  end

  def d
    @d ||= invmod(e, totient)
  end

  # Thanks for https://rosettacode.org/wiki/Modular_inverse#Ruby
  def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x, y, last_y = 0, 1, 1, 0
    while remainder != 0
      last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
      x, last_x = last_x - quotient*x, x
      y, last_y = last_y - quotient*y, y
    end

    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end

  # Thanks for https://rosettacode.org/wiki/Modular_inverse#Ruby
  def invmod(e, et)
    g, x = extended_gcd(e, et)
    raise 'The maths are broken!' if g != 1
    x % et
  end

  def random_prime_number
    number = Random.rand(10..100)
    until Prime.prime?(number) || number == p || number == q do
      number = Random.rand(100)
    end
    number
  end
end
