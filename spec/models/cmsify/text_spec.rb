require 'spec_helper'

module Cmsify
  describe Text do
    subject{ FactoryGirl.create(:text) }
    it { validate_presence_of(:content) }
    it { validate_presence_of(:slug) }
    it { validate_uniqueness_of(:slug) }
    it { belong_to(:owner) }
  end
end