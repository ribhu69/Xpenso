//
//  ColorExtension.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 02/06/24.
//

import Foundation
import SwiftUI

struct DynamicColor {
    var light: Color
    var dark: Color
    
    init(lightHex: String, darkHex: String) {
        self.light = Color(hex: lightHex)
        self.dark = Color(hex: darkHex)
    }
    
    func color(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .light:
            return light
        case .dark:
            return dark
        @unknown default:
            return light
        }
    }
}


extension Color {
    init(hex: String) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = Double(r) / 255.0
        let green = Double(g) / 255.0
        let blue  = Double(b) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
