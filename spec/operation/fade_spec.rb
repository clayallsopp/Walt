describe "Walt::Operation::FadeOperation" do
  before do
    @view = UIView.alloc.initWithFrame([[100,100], [50,50]])
  end

  describe "#setup" do
    describe "with :from" do
      it "should work" do
        op = Walt::Operation.for(type: :fade, id: :herp, from: 0.3)
        op.setup(@view, nil)
        @view.alpha.should == 0.3
      end
    end
  end

  describe "#finalize" do
    describe "with :to" do
      it "should work" do
        op = Walt::Operation.for(type: :fade, id: :herp, to: 0.8)
        op.finalize(@view, nil)
        @view.alpha.should == 0.8
      end
    end
  end
end