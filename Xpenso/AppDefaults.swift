//
//  AppDefaults.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SwiftUI

class ThemeManager : ObservableObject {
    static let shared = ThemeManager()
    @Published var appThemeColor = Color(.richTeal)
    private init() {}
}

class AppDefaults {
    static let shared = AppDefaults()
    private let userDefaults = UserDefaults.standard
    @Published var appThemeColor : Color!
    private init() {
        ThemeManager.shared.appThemeColor = color(forKey: AppConstants.appThemeColor.rawValue) ?? Color(.richTeal)
    }
    
    
    func getValue(for key: String) -> Any? {
        return userDefaults.value(forKey: key)
    }
    
    func setValue(key: String, value: Any) {
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func getAppThemeColor() -> Color {
        AppDefaults.shared.color(forKey: AppConstants.appThemeColor.rawValue) ?? Color(.richTeal)
    }
}

extension AppDefaults {
    func setColor(_ color: Color, forKey key: String) {
        
        appThemeColor = color
        let components = UIColor(color).cgColor.components
        userDefaults.set(components, forKey: key)
    }
    
    func color(forKey key: String) -> Color? {
        guard let colorComponents = userDefaults.object(forKey: key) as? [CGFloat] else {
            return Color(.richTeal) // returning default app color
        }
        let color = Color(
            .sRGB,
            red: colorComponents[0],
            green: colorComponents[1],
            blue: colorComponents[2],
            opacity: colorComponents[3]
        )
        print(color)
        return color
    }
}
