require 'spec_helper'

module Sisyphus
	describe ".print" do
		let(:obj){ FactoryGirl.build(:stone, {"global_id" => stone_gid, "name" => stone_name}) }
		let(:stone_gid){ '0000-0012'}
		let(:stone_name){ 'deleteme-stone'}
		it {
			#expect(nil).to be_nil
			expect{Sisyphus.print(obj)}.not_to raise_error
		}
	end
end
