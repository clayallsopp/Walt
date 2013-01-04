class AttrTest
  extend Walt::Support::AttrDefault

  attr_default :test, []
end

describe "Walt::Support::AttrDefault" do
  it "should work" do
    a = AttrTest.new
    a.respond_to?("test").should == true
    a.respond_to?("test=").should == true
    a.test.should == []
  end
end

describe "Walt::Font" do
  describe ".make" do
    [[:system, "systemFontOfSize:"], [:bold, "boldSystemFontOfSize:"], [:italic, "italicSystemFontOfSize:"]].each do |font, method|
      it "should work with system font #{font}" do
        f = Walt::Font.make(font, 12)
        f.should == UIFont.send(method, 12)

        f = Walt::Font.make(name: font, size: 12)
        f.should == UIFont.send(method, 12)
      end
    end

    it "should work with named font" do
      f = Walt::Font.make("Chalkduster", 12)
      f.should == UIFont.fontWithName("Chalkduster", size:12)
    end
  end

  describe ".attributes" do
    it "should work" do
      _attributes = Walt::Font.attributes(font: UIFont.systemFontOfSize(12), color: "red", shadow_color: "blue", shadow_offset: {x: 5, y: 10})

      _attributes.should == {
        UITextAttributeFont => UIFont.systemFontOfSize(12),
        UITextAttributeTextColor => UIColor.redColor,
        UITextAttributeTextShadowColor => UIColor.blueColor,
        UITextAttributeTextShadowOffset => NSValue.valueWithUIOffset(UIOffsetMake(5, 10))
      }
    end
  end
end