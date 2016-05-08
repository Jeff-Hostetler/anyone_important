defmodule AnyoneImportant.TwitterServiceSpec do
  use ESpec, skip: "calls twitter and there is a API call limit"
  alias AnyoneImportant.TwitterService

  context "twitter specs", context_tag: :twitter do
    describe "#search" do
      it "returns a list of tweet based on search term" do
        returned_list = TwitterService.search("@KanyeWest", "kanye")

        expect(Enum.count(returned_list)).to be_between(0,10)

        first_record = List.first(returned_list)
        expect(first_record).to have "kanye"
      end
    end
  end
end