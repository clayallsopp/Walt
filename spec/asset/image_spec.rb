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

    it "should raise exception without method" do
      asset = Walt::ImageAsset.new(url: "http://upload.wikimedia.org/wikipedia/commons/3/30/Googlelogo.png", id: "google")
      UIImageView.class_eval do
        alias_method :respond_to_old?, :respond_to?
        def respond_to?(val)
          if val == "af_imageRequestOperation"
            return false
          end
          respond_to_old?(val)
        end
      end
      lambda { asset.view }.should.raise Exception
      UIImageView.class_eval do
        def respond_to?(val)
          respond_to_old?(val)
        end
      end
      lambda { asset.view }.should.not.raise Exception
    end
  end
end