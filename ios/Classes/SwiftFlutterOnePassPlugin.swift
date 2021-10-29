import Flutter
import UIKit
import OneLoginSDK

public class SwiftFlutterOnePassPlugin: NSObject, FlutterPlugin {
    
    public static var channelName = "life.zrong/flutter_one_pass"
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterOnePassPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let method = call.method
    
    switch method {
    case "init":
        self.initSdk(call: call, result: result)
        break
    default:
        result(FlutterMethodNotImplemented)
    }
  }
    
    public func initSdk(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let appId = CommonUtils.getParam(call: call, result: result, param: "appId") as! String
        
        let _ = GOPManager.init(customID: appId, timeout: 8000)
        
        result(true)
    }
    
}
