class AppDelegate
  attr_reader :animation, :asset
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @window.makeKeyAndVisible

    Walt.animate(
      assets: [{
        id: :blue,
        url: "http://upload.wikimedia.org/wikipedia/commons/3/30/Googlelogo.png",
        size: [300,100]
      }, {
        id: :red,
        text: "Hello World",
        text_color: "white",
        position: [20, 50]
      }],
      animations:[{
        duration: 3,
        operations:[{
          fade: :red,
          from: 0.0,
          to: 1.0
        },{
          move: :blue,
          to: 100
        }, {
          fade: :blue,
          from: 0.0,
          to: 0.5
        }],
        after: {
          duration: 2,
          operations:[{
            rotate: :blue,
            to: 40
          },{
            move: :blue,
            to: 50
          }, {
            fade: :blue,
            from: 0.5,
            to: 1.0
          }],
          after: {
            duration: 2,
            operations: [{
              rotate: :blue,
              to: 0
            },{
              move: :blue,
              axis: :y,
              to: 150
            }]
          }
        }
      }],
      in: @window
    )

    true
  end
end
