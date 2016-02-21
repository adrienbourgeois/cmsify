require 'spec_helper'

RSpec.describe Cmsify::TextController, type: :controller do
  routes { Cmsify::Engine.routes }

  describe '#update' do
    let(:new_content) { 'new_content' }
    let!(:text) { FactoryGirl.create(:text) }
    context 'authorized user' do
      before do
        ::Cmsify.configure do |config|
          config.can_update = Proc.new do |request|
            true
          end
        end
      end

      context 'valid request' do
        subject { put :update, id: text.id, content: new_content, object_model: 'Cmsify::Text', field: 'content' }

        it "responds with a 200", focus:true do
          expect(subject.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok])
        end

        it "updates the text object in DB" do
          subject
          expect(text.reload.content).to eq(new_content)
        end
      end

      context 'request with unvalid slug' do
        subject { put :update, id: text.id-1, content: new_content, object_model: 'Cmsify::Text', field: 'content' }

        it "repsponds with a 404" do
          expect(subject.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found])
        end
      end
    end

    context 'unauthorized user' do
      before do
        ::Cmsify.configure do |config|
          config.can_update = Proc.new do |request|
            false
          end
        end
      end
      subject { put :update, id: text.id, content: new_content, object_model: 'Cmsify::Text', field: 'content' }

      it "responds with a 401" do
        expect(subject.response_code).to eq(Rack::Utils::SYMBOL_TO_STATUS_CODE[:unauthorized])
      end
    end
  end
end
