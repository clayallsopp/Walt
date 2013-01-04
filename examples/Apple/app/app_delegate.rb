class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible

    Walt.animate(
      assets: [{
        id: "google",
        position: [105, 0],
        size: [110, 40],
        url: "http://bit.ly/S98Ta5"
      }, {
        id: "apple",
        position: [110, UIScreen.mainScreen.bounds.size.height],
        size: [90, 80],
        url: "http://i.imgur.com/2ibBO.png"
      }, {
        id: "think",
        text: "Think Different",
        position: [100, 130]
      }],
      animations: [{
        duration: 0,
        operations: [{
          fade: "think",
          to: 0
        }]
      }, {
        duration: 2,
        operations: [{
          move: "google",
          to: 150,
          axis: :y
        }],
        after: {
          duration: 0.5,
          operations: [{
            rotate: "google",
            to: -90
          }],
          after: {
            delay: 1.25,
            duration: 0.5,
            operations: [{
              fade: "google",
              from: 1.0,
              to: 0.0
            }]
          }
        }
      }, {
        duration: 2,
        operations: [{
          move: "apple",
          to: 220,
          axis: :y
        }],
        after: {
          duration: 0.5,
          operations: [{
            rotate: "apple",
            to: -90
          }, {
            scale: "apple",
            to: 1.2
          }],
          after: {
            delay: 1,
            duration: 1.5,
            operations: [{
              move: "apple",
              to: 40,
              axis: :y
            }],
            after: {
              delay: 1,
              duration: 0.5,
              operations: [{
                rotate: "apple",
                to: 0
              }],
              after: {
                duration: 1,
                operations: [{
                  fade: "think",
                  to: 1.0
                }]
              }
            }
          }
        }
      }],
      in: @window
    )

    true
  end
end
