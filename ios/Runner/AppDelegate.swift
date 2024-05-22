import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var methodChannel:FlutterMethodChannel? = nil
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
             methodChannel = FlutterMethodChannel(name: "com.example.react_flutter/channel",
                                                        binaryMessenger: controller.binaryMessenger)
          methodChannel?.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              return self.handle(call: call, result: result)
            })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "react" {
        let rootView = ReactNativeViewController.sharedInstance.viewForModule(
                            "reactapp",
                            initialProperties: [:])

                    let reactNativeVC = UIViewController()
                            reactNativeVC.view = rootView
                            reactNativeVC.modalPresentationStyle = .fullScreen
                let controller : FlutterViewController = self.window?.rootViewController as! FlutterViewController
                controller.present(reactNativeVC, animated: true)

    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
