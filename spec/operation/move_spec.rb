describe "Walt::Operation::MoveOperation" do
  before do
    @view = UIView.alloc.initWithFrame([[100,100], [50,50]])
  end

  describe "#setup" do
    describe "with one param" do
      it "should work" do
        op = Walt::Operation.for(type: :move, id: :herp, from: 0)
        op.setup(@view)
        @view.origin.x.should == 0
      end
    end

    describe "with array" do
      it "should work" do
        op = Walt::Operation.for(type: :move, id: :herp, from: [200, 200])
        op.setup(@view)
        @view.origin.x.should == 200
        @view.origin.y.should == 200
      end
    end
  end

  describe "#finalize" do
    describe "with one param" do
      it "should work" do
        op = Walt::Operation.for(type: :move, id: :herp, to: 200)
        op.finalize(@view)
        @view.origin.x.should == 200
      end
    end

    describe "with array" do
      it "should work" do
        op = Walt::Operation.for(type: :move, id: :herp, to: [200, 200])
        op.finalize(@view)
        @view.origin.x.should == 200
        @view.origin.y.should == 200
      end
    end
  end
end