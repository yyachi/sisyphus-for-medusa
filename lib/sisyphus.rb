require "sisyphus/version"

module Sisyphus
  # Your code goes here...
  def self.port
  	8888
  end  

  def self.bind
  	'0.0.0.0'
  end

  @print_timeout = nil
  def self.default_print_timeout
  	10
  end
  def self.print_timeout=(time)
  	@print_timeout = time
  end
  def self.print_timeout
  	@print_timeout || default_print_timeout
  end

  @title = nil

  def self.default_title
  	'Sisyphus'
  end

  def self.title
  	@title || default_title
  end

  def self.title=(title)
  	@title = title
  end

  def self.open_command
	cmd = "open"
	case RUBY_PLATFORM.downcase
	when /mswin(?!ce)|mingw|bccwin/
		cmd = "start"
	when /cygwin/
		cmd = "cygstart"
	end
	cmd
  end

  def self.system(cmd)
  	system(cmd)
  end
end
