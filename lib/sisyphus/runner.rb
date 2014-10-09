require 'sisyphus'
require 'sisyphus/commands/server_command'


class Sisyphus::Runner
	def initialize(options = {})
  	#	@command_manager_class = options[:command_manager] || Tepra::CommandManager	
	end

	def run(args)
		cmd = Sisyphus::Commands::ServerCommand.new
		# cmd.command_names.each do |command_name|
		# 	config_args = Tepra.configuration[command_name]
		# end
		build_args = []
		cmd.invoke_with_build_args(args, build_args)		
	end
end
