describe "Walt::Animation" do
  describe "#after=" do
    before do
      @anim = Walt::Animation.new
    end

    it "works with hash" do
      after = {start: 0, duration: 3}
      @anim.after = after
      @anim.after.should.not == nil
    end

    it "works with Animation" do
      after = Walt::Animation.new(start: 0, duration: 3)
      @anim.after = after
      @anim.after.should == after
    end

    after do
      @anim.after.is_a?(Walt::Animation).should == true
      @anim.after.start.should == 0
      @anim.after.duration.should == 3
    end
  end

  describe "#operations=" do
    before do
      @anim = Walt::Animation.new
    end

    it "works with hash" do
      op = {type: :move}
      @anim.operations = [op]
      @anim.operations.should.not == nil
    end

    it "works with Operation" do
      op = Walt::Operation.for(type: :move)
      @anim.operations = [op]
      @anim.operations.should.not == nil
    end

    after do
      @anim.operations.length.should == 1
      @anim.operations.each {|op| op.is_a?(Walt::Operation::Base).should == true }
    end
  end

  describe "#assets=" do
    describe "with NSArray" do
      before do
        @anim = Walt::Animation.new
      end

      it "works with Assets" do
        asset = Walt::Asset.new(id: :hello, view: UIView.alloc.initWithFrame(CGRectZero))
        @anim.assets = [asset]
        @anim.assets.is_a?(NSDictionary).should == true
      end

      it "works with hash" do
        asset = {id: :hello, view: UIView.alloc.initWithFrame(CGRectZero)}
        @anim.assets = [asset]
        @anim.assets.is_a?(NSDictionary).should == true
      end

      after do
        @anim.assets.each {|key, value|
          value.is_a?(Walt::Asset).should == true
          key.should == value.id
        }
        @anim.assets[:hello].should.not == nil
      end
    end

    describe "with NSDictionary" do
      before do
        @anim = Walt::Animation.new
      end

      it "works with Assets" do
        asset = Walt::Asset.new(id: :hello, view: UIView.alloc.initWithFrame(CGRectZero))
        @anim.assets = {hello: asset}
        @anim.assets.is_a?(NSDictionary).should == true
      end

      it "works with hash" do
        asset = {id: :hello, view: UIView.alloc.initWithFrame(CGRectZero)}
        @anim.assets = {hello: asset}
        @anim.assets.is_a?(NSDictionary).should == true
      end

      after do
        @anim.assets.each {|key, value|
          value.is_a?(Walt::Asset).should == true
          key.should == value.id
        }
        @anim.assets[:hello].should.not == nil
      end
    end
  end

  describe "#options=" do
    describe "with constants" do
      before do
        @anim = Walt::Animation.new
      end

      it "works" do
        options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
        @anim.options = [UIViewAnimationOptionAutoreverse, UIViewAnimationOptionRepeat]
        @anim.animation_options.should == options
      end
    end

    describe "with symbols" do
      before do
        @anim = Walt::Animation.new
      end

      it "works" do
        options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
        @anim.options = [:autoreverse, :repeat]
        @anim.animation_options.should == options
      end
    end
  end
end