//
//  Environment.swift
//  Legible News
//
//  Created by Brad Gessler on 4/21/23.
//

import Foundation
import UIKit

struct Environment {
    static func getRootURL() -> URL {
        if let rootURLString = Bundle.main.object(forInfoDictionaryKey: "ROOT_URL") as? String,
           let rootURL = URL(string: rootURLString) {
            return rootURL
        } else {
            // Fallback URL if ROOT_URL is not set
            return URL(string: "https://legiblenews.com")!
        }
    }
    
    static func userAgent() -> String {
        // Get app version
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("App version: \(appVersion)")
        }

        // Get platform
        #if os(iOS)
            let platform = "iOS"
        #elseif os(watchOS)
            let platform = "watchOS"
        #elseif os(tvOS)
            let platform = "tvOS"
        #elseif os(macOS)
            let platform = "macOS"
        #else
            let platform = "Unknown"
        #endif
        print("Platform: \(platform)")

        // Get platform version
        let platformVersion = UIDevice.current.systemVersion
        print("Platform version: \(platformVersion)")
        
        return "LegibleNews/1.0 \(platform)/\(platformVersion)"
    }
}
