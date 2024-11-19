# frozen_string_literal: true

# sal_interpreter.rb
require_relative 'memory'
require_relative 'registers'
require_relative 'parser'
require_relative 'io_handler'

class SALInterpreter
  def initialize
    @memory = Memory.new
    @registers = ALIRegisters.new
    @program = []
  end

  # Load a program from a file
  def load_program(filename)
    File.open(filename, 'r') do |file|
      file.each_line.with_index do |line, index|
        next if line.strip.empty?

        # Parse and create instruction objects using Parser
        instruction = Parser.parse(line.strip)
        @memory.write_memory(index, line)
        @program[index] = instruction
      end
    end
  rescue Errno::ENOENT
    puts "File not found: #{filename}"
  end

  def execute_all
    instruction_limit = 1000
    instruction_count = 0

    while @registers.program_counter.value < @program.size
      current_pc = @registers.program_counter.value
      instruction = @program[current_pc]

      if instruction.nil?
        puts "No instruction at address #{current_pc}, halting."
        exit
      end

      instruction.execute(@memory, @registers)
      @registers.program_counter.value += 1
      instruction_count += 1  # Increment instruction count

      # Check if the instruction is HLT
      if instruction.is_a?(HLT)  # Assuming HLT is a class for HLT instruction
        puts "HLT instruction encountered. Stopping execution."
        break
      end

      # Check for cycle limit
      if instruction_count >= instruction_limit
        puts "Cycle limit exceeded (#{instruction_limit}). Halting execution."
        break
      end
    end

    IOHandler.display_state(@registers, @memory)
    (0...@registers.program_counter.value + 1).each do |address|
      instruction = @memory.read_memory(address)
      puts "Address #{address}: #{instruction}" unless instruction.nil?
    end
  end

  # Execute one instruction at a time
  def execute_single_step
    current_pc = @registers.program_counter.value
    instruction = @program[current_pc]

    if instruction.nil?
      IOHandler.no_instruction_found(current_pc)
      return
    end

    instruction.execute(@memory, @registers)
    IOHandler.display_state(@registers, @memory)
    @registers.program_counter.value += 1
  end
end
