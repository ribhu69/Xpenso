import Foundation
import SwiftUI

// Enum for font weights
enum FontWeight {
    case light
    case regular
    case semibold
    case medium
}

#if os(iOS)
import UIKit
typealias PlatformFont = UIFont
#elseif os(macOS)
import AppKit
typealias PlatformFont = NSFont
#endif

// Text extension to set custom font
extension Text {
    
    func setCustomFont(
        fontName: String = "Manrope-Regular",
        size: CGFloat = PlatformFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        self.font(.custom(fontName, size: size))
    }
    
    func setCustomFont(
        fontName: String = "Manrope-Regular",
        weight: FontWeight = .regular,
        size: CGFloat = PlatformFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        switch weight {
        case .light:
            return self.font(.custom("Manrope-Light", size: size))
        case .regular:
            return self.font(.custom("Manrope-Regular", size: size))
        case .semibold:
            return self.font(.custom("Manrope-SemiBold", size: size))
        case .medium:
            return self.font(.custom("Manrope-Medium", size: size))
        }
    }
}

// View extension to set custom font for both platforms
extension View {
    func setCustomFont(
        fontName: String = "Manrope-Regular",
        size: CGFloat = PlatformFont.preferredFont(forTextStyle: .body).pointSize
    ) -> some View {
        self.font(.custom(fontName, size: size))
    }
    
    func setCustomFont(
        fontName: String = "Manrope-Regular",
        weight: FontWeight = .regular,
        size: CGFloat = PlatformFont.preferredFont(forTextStyle: .body).pointSize
    ) -> some View {
        switch weight {
        case .light:
            return self.font(.custom("Manrope-Light", size: size))
        case .regular:
            return self.font(.custom("Manrope-Regular", size: size))
        case .semibold:
            return self.font(.custom("Manrope-SemiBold", size: size))
        case .medium:
            return self.font(.custom("Manrope-Medium", size: size))
        }
    }
}
