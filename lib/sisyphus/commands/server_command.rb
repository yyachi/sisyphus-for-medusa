require 'sisyphus/command'
require 'sisyphus/server'

class Sisyphus::Commands::ServerCommand < Sisyphus::Command
	def initialize
		super '', 'Sisyphus HTTP server', :port => 8888, :bind => '0.0.0.0', :title => 'Sisyphus', :print_timeout => 10

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

		add_option '-p', '--port=PORT', :Port, 'port to listen on' do |port, options|
			options[:port] = port
		end

		add_option '-t', '--title=TITLE', 'title of application' do |title, options|
			options[:title] = title
		end

		add_option '-o', '--print-timeout=TIME', 'timeout of print' do |time, options|
			options[:print_timeout] = time.to_i
		end

#		add_option '-b', '--bind=HOST,HOST','addresses to bind', Array do |address, options|
#			options[:bind] ||= []
#			options[:bind].push(*address)
#		end

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
		Sisyphus::Server.run! options
	end
end
