
import Foundation
import React

class ReactNativeViewController: NSObject {
    var bridge: RCTBridge?
    
    static let sharedInstance = ReactNativeViewController()
    
    func createBridgeIfNeeded() -> RCTBridge {
        if bridge == nil {
            bridge = RCTBridge.init(delegate: self, launchOptions: nil)
        }
        return bridge!
    }
    
    func viewForModule(_ moduleName: String, initialProperties: [String : Any]?) -> RCTRootView {
        let viewBridge = createBridgeIfNeeded()
        let rootView: RCTRootView = RCTRootView(
            bridge: viewBridge,
            moduleName: moduleName,
            initialProperties: initialProperties)
        return rootView
    }
}

extension ReactNativeViewController: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
            return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
//             return URL(string: "http://localhost:8081/index.bundle?platform=ios") //use this if you are running the react native server
    }
}
