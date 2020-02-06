require 'sisyphus/command'
require 'sisyphus/server'

class Sisyphus::Commands::ServerCommand < Sisyphus::Command
	def initialize
		super '', 'Sisyphus HTTP server', :port => 8890, :bind => '0.0.0.0', :title => 'Sisyphus', :print_timeout => 10

		OptionParser.accept :Port do |port|
			if port =~ /\A\d+\z/ then
				port = Integer port
				raise OptionParser::InvalidArgument, "#{port}: not a port number" if
				port > 65535
				port
			else
				begin
					Socket.getservbyname port
				rescue SocketError
					raise OptionParser::InvalidArgument, "#{port}: no such named service"
				end
			end
		end

		add_option '-p', '--port=PORT', :Port, 'port to listen to' do |port, options|
			options[:port] = port
		end

		add_option '-t', '--title=TITLE', 'title of application' do |title, options|
			options[:title] = title
		end

		add_option '-o', '--print-timeout=TIME', 'timeout on printing' do |time, options|
			options[:print_timeout] = time.to_i
		end

#		add_option '-b', '--bind=HOST,HOST','addresses to bind', Array do |address, options|
#			options[:bind] ||= []
#			options[:bind].push(*address)
#		end

	end

def description
		<<-EOF
Create stone in Medusa and print barcode label on MS-Windows.  This is
a web-app that runs on PC.  By accessing the server by web browser
that runs remotely or locally, an user can create a stone with label.

Synopsis:
    CMD> sisyphus

See Also:
    http://dream.misasa.okayama-u.ac.jp

History:
    August 11, 2018: Add documentation by TK.

Implementation:
    Copyright (C) 2015-2020 Okayama University
    License GPLv3+: GNU GPL version 3 or later

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3, or (at your option)
    any later version.

EOF
	end

    def execute
		args = options.delete(:args)
		build_args = options.delete(:build_args)
		title = options.delete(:title)
		Sisyphus.title = title if title
		print_timeout = options.delete(:print_timeout)
		Sisyphus.print_timeout = print_timeout if print_timeout
		app_url = "http://localhost:#{options[:port]}"
		launch_cmd = "#{Sisyphus.open_command} #{app_url}"
		Sisyphus.execute_command(launch_cmd)
		run_server(options)
		#Sisyphus::Server.run! options
	end

	def run_server(options)
		Sisyphus::Server.run! options
	end
end
