require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {Question.create!(title: "Question Title", body: "Question Body")}
    describe "attributes" do
      it "has title and body attributes" do
        expect(question).to have_attributes(title: "Question Title", body: "Question Body")
    end
  end
end
