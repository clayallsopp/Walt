describe "Walt::AnimationSet" do
  describe "#assets=" do
    before do
      @set = Walt::AnimationSet.new
    end

    it "works with Assets" do
      asset = Walt::Asset.new(id: :hello, view: UIView.alloc.initWithFrame(CGRectZero))
      @set.assets = [asset]
      @set.assets.is_a?(NSArray).should == true
    end

    it "works with hash" do
      asset = {id: :hello, view: UIView.alloc.initWithFrame(CGRectZero)}
      @set.assets = [asset]
      @set.assets.is_a?(NSArray).should == true
    end

    after do
      @set.assets.each {|value|
        value.is_a?(Walt::Asset).should == true
      }
    end
  end

  describe "#animations=" do
    before do
      @set = Walt::AnimationSet.new
    end

    it "works with Assets" do
      animation = Walt::Animation.new(delay: 0, duration: 3)
      @set.animations = [animation]
      @set.animations.is_a?(NSArray).should == true
    end

    it "works with hash" do
      animation = {delay: 0, duration: 3}
      @set.animations = [animation]
      @set.animations.is_a?(NSArray).should == true
    end

    after do
      @set.animations.each {|value|
        value.is_a?(Walt::Animation).should == true
      }
    end
  end
end