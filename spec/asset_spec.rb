describe "Walt::Asset" do
  describe ".new" do
    describe "with a UIView" do
      it "should work" do
        view = UIView.alloc.initWithFrame([[0,0,],[100,100]])
        a = Walt::Asset.new(view)
        a.view.should == view
      end
    end
  end
end