# frozen_string_literal: true

class Registers
  MAX_VALUE = 2**15 - 1   # Max value for a 16-bit signed integer
  MIN_VALUE = -2**15      # Min value for a 16-bit signed integer

  def initialize
    @value = 0
  end

  # Getter for register value
  def value
    @value
  end

  # Setter for register value
  def value=(new_value)
    unless new_value.between?(MIN_VALUE, MAX_VALUE)
      raise "Value out of range for 16-bit register: #{new_value}"
    end
    @value = new_value
  end

  # Reset the register value to zero
  def reset
    @value = 0
  end
end

# Class for the 8-bit Program Counter (PC)
class ProgramCounter
  MAX_VALUE = 127  # Max value for an 8-bit unsigned integer

  def initialize
    @value = 0
  end

  # Getter for PC value
  def value
    @value
  end

  # Setter for PC value
  def value=(new_value)
    unless new_value.between?(0, MAX_VALUE)
      raise "Value out of range for Program Counter: #{new_value}"
    end
    @value = new_value
  end

  # Reset the PC value to zero
  def reset
    @value = 0
  end
end

# Zero bit (boolean flag)
class ZeroBit
  def initialize
    @value = false
  end

  # Getter for zero bit
  def value
    @value
  end

  # Setter for zero bit
  def value=(new_value)
    @value = new_value
  end

  # Reset the zero bit to false
  def reset
    @value = false
  end
end

# Instantiate the register components
class ALIRegisters
  attr_reader :accumulator, :data_register, :program_counter, :zero_bit

  def initialize
    @accumulator = Registers.new
    @data_register = Registers.new
    @program_counter = ProgramCounter.new
    @zero_bit = ZeroBit.new
  end
end
