require 'rails_helper'

describe PagesController, type: :controller do

  describe 'GET #index' do
    context 'with active login session' do
      it 'populates an array of the current user conversations' do
      end

      it "redirect to conversations :index" do
      end

      it 'populates an arry of public conversations' do
      end
    end

    context 'without active login session' do
      it "populates a collection of public conversations" do
        first_conversation = create(:conversation)
        second_conversation  = create(:conversation)
        hi = create(:message)
        hey = create(:message)
        second_conversation.messages << hey
        first_conversation.messages << hi
        get :index
        expect(assigns(:public_conversations)).to match_array(
          [first_conversation, second_conversation])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
