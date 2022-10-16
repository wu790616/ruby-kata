# https://exercism.org/tracks/ruby/exercises/simple-calculator
class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise ArgumentError        if !first_operand.is_a?(Integer) || !second_operand.is_a?(Integer)
    raise UnsupportedOperation if !ALLOWED_OPERATIONS.include?(operation)

    begin
      ans = first_operand.method(operation).call(second_operand)
      "#{first_operand} #{operation} #{second_operand} = #{ans}"
    rescue ZeroDivisionError
      'Division by zero is not allowed.'
    end
  end
end
