import Foundation

public enum EnvironmentSetup {
    
    public static var envSetup: [String: AnyObject]? {
        return Bundle.main.infoDictionary?["EnvironmentSetup"] as? [String: AnyObject]
    }
    
    public static var host: String? {
        return envSetup?["HOST"] as? String
    }
}
