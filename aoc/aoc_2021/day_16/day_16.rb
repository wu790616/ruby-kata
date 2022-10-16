class Day16
  attr_accessor :data

  def initialize
    @data    = File.read('day_16.txt').strip
    @packets = []
  end

  def part1
    packets = init_packets(binary_data, [])

    packets.map do |p|
      p[0..2].to_i(2)
    end.sum
  end

  def binary_data
    data.to_i(16).to_s(2).rjust(data.size * 4, '0')
  end

  def init_packets(binary_str, packets)
    return packets if binary_str.to_i.zero?

    type_id = binary_str[3..5].to_i(2)
    str     = binary_str[6..-1]

    packet_length = if type_id == 4
                      literal_value(str)
                    else
                      length_type_id = binary_str[6].to_i
                      length_bits    = length_type_id.zero? ? 15 : 11

                      6 + 1 + length_bits
                    end

    packets << binary_str[0...packet_length]
    init_packets(binary_str[packet_length..-1], packets)
  end

  def literal_value(packet)
    packet.scan(/.{1,5}/).each.with_index(1) do |bits, idx|
      return (6 + idx * 5 ) if bits[0] == '0'
    end
  end
end

p Day16.new.part1
