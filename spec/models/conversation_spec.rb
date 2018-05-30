require "rails_helper"

RSpec.describe Conversation, :type => :model do
    it "Create a conversation between two users" do
        mario = User.create(:first_name => "Mario", :last_name => "Rossi", :email => "mario_rossi@test.it", :password => "123456", :password_confirmation => "123456", :username => "mario")
        luca = User.create(:first_name => "Luca", :last_name => "Bianchi", :email => "luca_bianchi@test.it", :password => "123456", :password_confirmation => "123456", :username => "luca")
        conversation = Conversation.create(:sender_id => mario.id, :recipient_id => luca.id)
        expect(mario.conversations.first).to eq(conversation)
    end

    it "Create a conversation with only one user" do
        mario = User.create(:first_name => "Mario", :last_name => "Rossi", :email => "mario_rossi@test.it", :password => "123456", :password_confirmation => "123456", :username => "mario")
        conversation = Conversation.create(:sender_id => mario.id)
        expect(conversation).not_to be_valid
    end
end