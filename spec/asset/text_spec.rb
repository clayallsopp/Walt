describe "Walt::TextAsset" do
  describe "#view" do
    describe "with attributes hash" do
      it "should work" do
        @asset = Walt::TextAsset.new(attributes: {font: {name: "MarkerFelt-Thin", size: 24}, color: "blue", shadow_color: "red", shadow_offset: {x: 10, y: 20}})
        @asset.view.font.should == UIFont.fontWithName("MarkerFelt-Thin", size:24)
        @asset.view.textColor.should == UIColor.blueColor
        @asset.view.shadowColor.should == UIColor.redColor
        @asset.view.shadowOffset.should == CGSizeMake(10, 20)
      end
    end

    describe "without attributes hash" do
      it "should work" do
        @asset = Walt::TextAsset.new(text: "Hello World", text_color: "blue", "background_color" => "red", number_of_lines: 5, text_alignment: "center")
        @asset.view.text.should == "Hello World"
        @asset.view.textColor.should == UIColor.blueColor
        @asset.view.backgroundColor.should == UIColor.redColor
        @asset.view.numberOfLines.should == 5
        @asset.view.textAlignment.should == UITextAlignmentCenter
      end
    end
  end
end