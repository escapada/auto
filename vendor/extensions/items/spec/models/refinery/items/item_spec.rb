require 'spec_helper'

module Refinery
  module Items
    describe Item do
      describe "validations" do
        subject do
          FactoryGirl.create(:item,
          :model => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:model) { should == "Refinery CMS" }
      end
    end
  end
end
