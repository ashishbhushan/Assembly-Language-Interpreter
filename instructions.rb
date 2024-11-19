# frozen_string_literal: true

class Instructions
  attr_reader :opcode

  def initialize(opcode)
    @opcode = opcode
  end

  # This method will be overridden in subclasses
  def execute(_memory, _registers)
    raise NotImplementedError, 'Subclasses must implement the execute method'
  end
end

# Subclass for the DEC (Declare Variable) instruction
class DEC < Instructions
  def initialize(symbol)
    super('DEC')
    @symbol = symbol
  end

  def execute(memory, registers)
    address = memory.allocate_variable(@symbol)
    puts "Declared variable '#{@symbol}' at address #{address}."
  end
end

# Subclass for the LDA (Load Accumulator) instruction
class LDA < Instructions
  def initialize(symbol)
    super('LDA')
    @symbol = symbol
  end

  def execute(memory, registers)
    address = @symbol
    registers.accumulator.value = memory.read_memory(address)
  end
end

# Subclass for the LDI (Load Immediate) instruction
class LDI < Instructions
  def initialize(value)
    super('LDI')
    @value = value
  end

  def execute(_memory, registers)
    registers.accumulator.value = @value
  end
end

# Subclass for the STR (Store) instruction
class STR < Instructions
  def initialize(symbol)
    super('STR')
    @symbol = symbol
  end

  def execute(memory, registers)
    address = @symbol
    memory.write_memory(address, registers.accumulator.value)
  end
end

# Subclass for the XCH (Exchange) instruction
class XCH < Instructions
  def initialize
    super('XCH')
  end

  def execute(_memory, registers)
    # Exchange the values between the accumulator and data register
    temp = registers.accumulator.value
    registers.accumulator.value = registers.data_register.value
    registers.data_register.value = temp
  end
end

# Subclass for the ADD instruction
class ADD < Instructions
  def initialize
    super('ADD')
  end

  def execute(_memory, registers)
    proposed_sum = registers.accumulator.value + registers.data_register.value
    # Check for overflow before updating the accumulator
    if proposed_sum < Registers::MIN_VALUE || proposed_sum > Registers::MAX_VALUE

      return  # Exit early to prevent invalid state
    end
    registers.accumulator.value = proposed_sum
    registers.zero_bit.value = (proposed_sum == 0)
  end
end

# Subclass for the SUB instruction
class SUB < Instructions
  def initialize
    super('SUB')
  end

  def execute(_memory, registers)
    result = registers.accumulator.value - registers.data_register.value
    if result < Registers::MIN_VALUE || result > Registers::MAX_VALUE
      return  # Optionally handle the overflow case
    end
    registers.accumulator.value = result
    registers.zero_bit.value = (result == 0)
  end
end


# Subclass for the JMP (Jump) instruction
class JMP < Instructions
  def initialize(address)
    super('JMP')
    @address = address
  end

  def execute(_memory, registers)
    registers.program_counter.value = @address
  end
end

# Subclass for the JZS (Jump if Zero Set) instruction
class JZS < Instructions
  def initialize(address)
    super('JZS')
    @address = address
  end

  def execute(_memory, registers)
    if registers.zero_bit.value
      registers.program_counter.value = @address
    end
  end
end

# Subclass for the HLT (Halt) instruction
class HLT < Instructions
  def initialize
    super('HLT')
  end

  def execute(_memory, _registers)
    puts "Program halted."
  end
end