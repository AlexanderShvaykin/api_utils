RSpec.describe ApiUtils do
  describe ".camelize" do
    subject { described_class.camelize("something_like_this") }

    it "camelize world" do
      expect(subject).to eq "somethingLikeThis"
    end
  end

  describe ".camelize_keys" do
    subject do
      described_class.camelize_keys(
        foo_bar: 'val', baz: { main_params: "val", params: 'val' }, params: [user_id: 1]
      )
    end

    it "camelize hash" do
      expect(subject)
        .to eq "fooBar" => 'val',
               "baz"    => { "mainParams" => "val", "params" => 'val' },
               "params" => ["userId" => 1]
    end
  end

  describe ".symbolize_keys" do
    subject do
      described_class.symbolize_keys(
        "fooBar" => 'val',
        "baz"    => { "mainParams" => "val", "params" => 'val' },
        "params" => ["userId" => 1]
      )
    end

    it "symbolize hash keys" do
      expect(subject)
        .to eq fooBar: 'val',
               baz:    { mainParams: "val", params: 'val' }, params: [userId: 1]
    end
  end
end
