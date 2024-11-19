# frozen_string_literal: true

# io_handler.rb
class IOHandler
  # Ask the user for the filename of the SAL program
  def self.get_program_filename
    print "Enter the filename of the SAL program: "  # Using print for inline input
    gets.chomp  # Read input from user and remove trailing newline
  end

  # Ask the user for the command to execute (single step, all, or quit)
  def self.get_command
    print "Commands: (s)ingle step, (a)ll, (q)uit: "  # Print commands for clarity
    gets.chomp.downcase  # Read and normalize input
  end

  # Display the current state of the registers and memory
  def self.display_state(registers, memory)
    puts "----- Current State -----"
    puts "PC: #{registers.program_counter.value}"
    puts "Accumulator: #{registers.accumulator.value}"
    puts "Data Register: #{registers.data_register.value}"
    puts "Zero Bit: #{registers.zero_bit.value}"

    current_address = registers.program_counter.value
    instruction = memory.read_memory(current_address)

    puts "--- Current Instruction ---"
    if instruction.is_a?(Instructions)  # Ensure it's an instruction object
      puts "Address #{current_address}: #{instruction}"
    elsif instruction.is_a?(String)
      puts "Address #{current_address}: #{instruction}"
    else
      puts "No instruction found at Address #{current_address}."
    end
    puts "-------------------------"
  end

  # Display message when no instruction is found at a given program counter value
  def self.no_instruction_found(pc)
    puts "No instruction at address #{pc}, halting."
    exit
  end

  # Display program halted message
  def self.program_halted
    puts "Program halted."
  end

  # Display error message for unknown commands
  def self.unknown_command
    puts "Unknown command. Use 's' for single step, 'a' for all, or 'q' to quit."
  end
end
