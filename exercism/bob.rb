class Bob
  def self.hey(remark)
    remark      = remark.strip
    is_yell     = /[A-Z]+/.match?(remark) && (remark == remark.upcase)
    is_question = remark.end_with?('?')
    is_silence  = remark.empty?

    return "Calm down, I know what I'm doing!" if is_yell && is_question
    return 'Whoa, chill out!'                  if is_yell
    return 'Sure.'                             if is_question
    return 'Fine. Be that way!'                if is_silence

    'Whatever.'
  end
end
