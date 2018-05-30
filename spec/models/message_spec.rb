require "rails_helper"

RSpec.describe Message, :type => :model do
    it "Create a message" do
        mario = User.create(:first_name => "Mario", :last_name => "Rossi", :email => "mario_rossi@test.it", :password => "123456", :password_confirmation => "123456", :username => "mario")
        luca = User.create(:first_name => "Luca", :last_name => "Bianchi", :email => "luca_bianchi@test.it", :password => "123456", :password_confirmation => "123456", :username => "luca")
        conversation = Conversation.create(:sender_id => mario.id, :recipient_id => luca.id)
        message = Message.create(:user_id => mario.id, :conversation_id => conversation.id)
        expect(conversation.messages.first).to eq(message)
    end

    it "Create a message with no conversation" do
        mario = User.create(:first_name => "Mario", :last_name => "Rossi", :email => "mario_rossi@test.it", :password => "123456", :password_confirmation => "123456", :username => "mario")
        message = Message.create(:user_id => mario.id)
        expect(message).not_to be_valid
    end
end