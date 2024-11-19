# frozen_string_literal: true

class Memory
  PROGRAM_MEMORY_SIZE = 128
  DATA_MEMORY_SIZE = 128
  MAX_VALUE = 2**15 - 1   # Max value for a 16-bit signed integer
  MIN_VALUE = -2**15      # Min value for a 16-bit signed integer

  def initialize
    @program_memory = Array.new(PROGRAM_MEMORY_SIZE, 0)
    @data_memory = Array.new(DATA_MEMORY_SIZE, 0)
    @symbol_table = {}
    @next_available_address = 0  # Points to the next available address in data memory
  end

  # Allocate a variable and return its address
  def allocate_variable(symbol)
    if @symbol_table.key?(symbol)
      raise "Variable '#{symbol}' already declared."
    end

    if @next_available_address >= DATA_MEMORY_SIZE
      raise "No available memory for new variable."
    end

    address = PROGRAM_MEMORY_SIZE + @next_available_address
    @symbol_table[symbol] = address
    @next_available_address += 1
    address
  end

  # Method to read from memory
  def read_memory(address)
    if valid_program_address?(address)
      @program_memory[address]
    elsif valid_data_address?(address)
      @data_memory[address - PROGRAM_MEMORY_SIZE]
    else
      raise "Invalid memory address: #{address}"
    end
  end

  # Method to write to memory
  def write_memory(address, value)
    # Ensure value is within the 16-bit signed integer range
    if value.is_a?(Integer)
      unless value.between?(MIN_VALUE, MAX_VALUE)
        raise "Value out of range: #{value}"
      end
    end


    if valid_program_address?(address)
      @program_memory[address] = value  # Store the instruction directly
    elsif valid_data_address?(address)
      @data_memory[address - PROGRAM_MEMORY_SIZE] = value
    else
      raise "Invalid memory address: #{address}"
    end
  end

  private

  # Check if the address is within program memory
  def valid_program_address?(address)
    address >= 0 && address < PROGRAM_MEMORY_SIZE
  end

  # Check if the address is within data memory
  def valid_data_address?(address)
    address >= PROGRAM_MEMORY_SIZE && address < PROGRAM_MEMORY_SIZE + DATA_MEMORY_SIZE
  end
end