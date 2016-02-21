require 'spec_helper'

module Cmsify
  include ActionDispatch::TestProcess

  describe Helpers do
    subject do
      Class.new.extend(Helpers)
    end

    before do
      ::Cmsify.configure do |config|
        config.can_update = Proc.new do |request|
          false
        end
      end

      subject.class_eval do
        def self.request
          true
        end
      end
    end

    describe '#abc' do
      context 'slug does not exist' do
        let(:slug) { :slug_that_does_not_exist }

        it "creates a new text instance" do
          expect{ subject.abc(slug: slug) }.to change{ ::Cmsify::Text.count }.by(1)
        end
      end

      context 'slug already exists' do
        let(:slug) { :slug_that_aready_exists }
        let(:content) { Faker::Lorem.sentence }
        let!(:text) { FactoryGirl.create(:text, slug: slug, content: content) }

        it "does not create a new text instance" do
          expect{ subject.abc(slug: slug) }.to change{ ::Cmsify::Text.count }.by(0)
        end

        it "returns the content of the text instance" do
          expect(subject.abc(slug: slug)).to eq(content)
        end
      end
    end
  end
end