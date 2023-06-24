module TwelveDays
  REF = [
    ['first',    'a Partridge in a Pear Tree'],
    ['second',   'two Turtle Doves'],
    ['third',    'three French Hens'],
    ['fourth',   'four Calling Birds'],
    ['fifth',    'five Gold Rings'],
    ['sixth',    'six Geese-a-Laying'],
    ['seventh',  'seven Swans-a-Swimming'],
    ['eighth',   'eight Maids-a-Milking'],
    ['ninth',    'nine Ladies Dancing'],
    ['tenth',    'ten Lords-a-Leaping'],
    ['eleventh', 'eleven Pipers Piping'],
    ['twelfth',  'twelve Drummers Drumming']
  ]

  def self.song
    (0..11).map do |line|
      "#{first_lyric(line)} #{second_lyric(line)}.\n"
    end.join("\n")
  end

  def self.first_lyric(line)
    "On the #{REF[line][0]} day of Christmas my true love gave to me:"
  end

  def self.second_lyric(line)
    case line
    when 0 then REF[line][1]
    when 1 then "#{REF[line][1]}, and #{second_lyric(0)}"
    else
      "#{REF[line][1]}, #{second_lyric(line - 1)}"
    end
  end
end
