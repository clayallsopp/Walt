describe "Walt::ImageAsset" do
  describe "#initialize" do
    it "should work with multi params" do
      asset = Walt::ImageAsset.new(url: "derp", id: "blue")
      asset.url.should == "derp"
      asset.id.should == "blue"
    end
  end

  describe "#view" do
    it "should create remote UIImageView" do
      asset = Walt::ImageAsset.new(url: "http://upload.wikimedia.org/wikipedia/commons/3/30/Googlelogo.png", id: "google")
      asset.view.af_imageRequestOperation.should.not == nil
    end
  end
end