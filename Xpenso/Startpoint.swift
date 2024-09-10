//
//  StartPoint.swift
//  LastPage
//
//  Created by Arkaprava Ghosh on 27/12/23.
//

import Foundation
import SwiftUI


class StartPoint {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
//    static func initialize() -> NotesListView {
    static func initialize() -> ExpenseTabBar {
        
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
        else {
            //freshInstall
            AppDefaults.shared.setValue(key: "CFBundleShortVersionString", value: currentAppVersion)
            AppDefaults.shared.setColor(Color(.richTeal), forKey: AppConstants.appThemeColor.rawValue)

        }
        return ExpenseAssembler.getTabBar(context: .init(DatabaseHelper.shared.getContainer()))
    }
}


