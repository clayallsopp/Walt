class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @window.makeKeyAndVisible

    url = "http://upload.wikimedia.org/wikipedia/commons/7/7a/Basketball.png"
    assets = (0..4).collect {|i| {
      id: "ball_#{i}",
      url: url,
      size: [50, 50],
      position: [i*50 + i*10, 0]
    } }

    height = UIScreen.mainScreen.bounds.size.height
    points = [height - 50, height - 150, height - 50, height - 100, height - 50]

    make_point_animation = lambda {|id, index|
      after = (index < (points.length - 1)) ? make_point_animation.call(id, index+1) : nil
      h = {
        duration: 0.5 / (index + 1).to_f + rand(),
        operations: [{
          move: id,
          to: points[index],
          axis: :y
        }, {
          rotate: id,
          to: rand() * 90
        }],
        after: after
      }
      h.delete(:after) if after.nil?
      h
    }

    animations = []
    assets.each_with_index do |asset, i|
      animations << make_point_animation.call(asset[:id], 0)
    end

    Walt.animate(
      assets: assets,
      animations: animations,
      in: @window
    )

    true
  end
end
