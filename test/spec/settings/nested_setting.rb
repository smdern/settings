require 'json'

data = JSON.load <<JSON
  {
    "some_setting": {
      "some_nested_setting": "some nested value"
    }
  }
JSON

describe Settings do
  let(:settings) { Settings.new data }
  let(:setting) { settings.get key }

  describe "Getting" do
    describe "A nested setting" do
      let(:key) { ['some_setting', 'some_nested_setting'] }
      specify "Gets the nested value" do
        expect(setting).to eq "some nested value"
      end
    end
  end
end