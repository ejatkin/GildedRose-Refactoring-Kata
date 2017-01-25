require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  context "for normal items, excluding brie and sulfuras" do
    it "lowers the value of the selln value by 1 at the end of each day" do
      items = [Item.new("bread", 10, 15)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].sell_in).to eq 9
    end

    it "lowers the quality value by 1 at the end of each day" do
      items = [Item.new("bread", 10, 15)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 14
    end




  end

end
