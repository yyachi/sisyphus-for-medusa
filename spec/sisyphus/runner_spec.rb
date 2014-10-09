require 'spec_helper'
require 'sisyphus/runner'
module Sisyphus
	describe Runner do
		#subject{ Sisyphus::Runner.run args }
		let(:args){ ["--port", "#{port}"] }
		let(:port){ 8988 }
		let(:bind){ '0.0.0.0' }
		let(:app){ Sisyphus::Runner.new }
		before do
			Sisyphus::Server = double("Sisyphus::Server")
			allow(Sisyphus::Server).to receive(:run!)
			allow(Sisyphus).to receive(:system).and_return(true)
			allow(Sisyphus).to receive(:open_command).and_return('ooopen')
		end

		#it { expect(Sisyphus::Commands::ServerCommand).to receive(:invoke_with_build_args).with(args)}
		it "should call Sisyphus.system" do
			expect(Sisyphus).to receive(:system).with("#{Sisyphus.open_command} http://localhost:#{port}").and_return(true)
			app.run args
		end
		it "should call Sisyphus::Commands::ServerCommand.invoke" do
			expect(Sisyphus::Server).to receive(:run!).with({:port => port, :bind => bind })
			app.run args
		end
	end
end