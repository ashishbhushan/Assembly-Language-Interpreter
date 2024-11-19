# frozen_string_literal: true

# parser.rb
require_relative 'instructions'

class Parser
  def self.parse(line)
    parts = line.split
    opcode = parts[0].upcase

    case opcode
    when 'DEC'
      DEC.new(parts[1])  # Expecting a symbol as an argument
    when 'LDA'
      LDA.new(parts[1].to_i)
    when 'LDI'
      LDI.new(parts[1].to_i)
    when 'STR'
      STR.new(parts[1].to_i)
    when 'XCH'
      XCH.new  # No arguments
    when 'ADD'
      ADD.new
    when 'SUB'
      SUB.new
    when 'JMP'
      JMP.new(parts[1].to_i)
    when 'JZS'
      JZS.new(parts[1].to_i)
    when 'HLT'
      HLT.new
    else
      raise "Unknown instruction: #{opcode}"
    end
  end
end
