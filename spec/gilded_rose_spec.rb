require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  context "system lowers selln and quality values for every item daily" do

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

  context "additional quirks for quality" do
    it "quality degrades twice as fast once sell by date has passed" do
      items = [Item.new("bread", 0, 15)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 13
    end

    it "the quality of an item is never negative" do
      items = [Item.new("bread", 10, 0)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 0
    end

  end

  context "aged brie" do

    it "the quality of an item is never more than 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 50
    end

    it "the quality of aged brie increases the older it gets" do
      items = [Item.new("Aged Brie", 10, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 26
    end

  end

  context "sulfuras" do

    it "never has to be sold" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].sell_in).to eq 0
    end

    it "never decreases in quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 25
    end

  end

  context "backstage passes" do

    it "quality increases by 2 daily when there are 10 days or less to go until it" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 27
    end

    it "quality increases by 3 when there are 5 days or less to go" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 28
    end

    it "quality drops to zero after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 25)]
      gilded_rose = GildedRose.new(items)
      gilded_rose.update_quality
      expect(items[0].quality).to eq 0
    end

  end





end
