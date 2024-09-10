//
//  MacStartPoint.swift
//  XpensoMac
//
//  Created by Arkaprava Ghosh on 10/09/24.
//

import Foundation


class MacStartPoint {
    static func initialize() -> ContentView {
        _ = DatabaseHelper.shared
        guard let currentAppVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            fatalError("App Version or build version does not exist.")
        }
        
        if let previousAppVersion = AppDefaults.shared.getValue(for: "CFBundleShortVersionString") as? String {
            if previousAppVersion < currentAppVersion {
                
                print("Migration Needed")
                AppDefaults.shared.setValue(key: "CFBundleShortVersionString", value: currentAppVersion)
            }
        }
        return ContentView()
    }
}
