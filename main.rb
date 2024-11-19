# frozen_string_literal: true

# main.rb
require_relative 'sal_interpreter'
require_relative 'io_handler'

interpreter = SALInterpreter.new

# Get the filename of the SAL program from the user
filename = IOHandler.get_program_filename
interpreter.load_program(filename)

loop do
  command = IOHandler.get_command  # Get command input from the user
  case command
  when 's'
    interpreter.execute_single_step
  when 'a'
    interpreter.execute_all
    break
  when 'q'
    break
  else
    IOHandler.unknown_command  # Handle unknown commands
  end
end

IOHandler.program_halted  # Indicate that the program has been halted
