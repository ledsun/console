# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2019-2022, by Samuel Williams.

require 'console/terminal/xterm'

describe Console::Terminal::XTerm do
	let(:io) {StringIO.new}
	let(:terminal) {subject.new(io)}
	
	it "can generate simple style" do
		expect(terminal.style(:blue)).to be == "\e[34m"
	end
	
	it "can generate complex style" do
		expect(terminal.style(:blue, nil, :underline, :bold)).to be == "\e[34;4;1m"
	end
	
	it "can write text with specified style" do
		terminal[:bold] = terminal.style(nil, nil, :bold)
		
		terminal.write("Hello World", style: :bold)
		
		expect(io.string).to be == "\e[1mHello World\e[0m"
	end
	
	it "can puts text with specified style" do
		terminal[:bold] = terminal.style(nil, nil, :bold)
		
		terminal.puts("Hello World", style: :bold)
		
		expect(io.string.split(/\r?\n/)).to be == ["\e[1mHello World", "\e[0m"]
	end
	
	with '#print' do
		it "can print using the specified style" do
			terminal[:bold] = terminal.style(nil, nil, :bold)
			
			terminal.print(:bold, "Hello World")
			
			expect(io.string).to be == "\e[1mHello World"
		end
	end
	
	with '#print_line' do
		it "can print a line using the specified style" do
			terminal[:bold] = terminal.style(nil, nil, :bold)
			
			terminal.print_line(:bold, "Hello World")
			
			expect(io.string.split(/\r?\n/)).to be == ["\e[1mHello World\e[0m"]
		end
	end
end
