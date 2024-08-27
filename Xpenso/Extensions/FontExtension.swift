//
//  FontExtension.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 25/08/24.
//

import Foundation
import SwiftUI

enum FontWeight {
    case light
    case regular
    case semibold
    case medium
}
extension Text {
    
    func setCustomFont(
//        fontName: String = "Quicksand-Regular",
        fontName: String = "Manrope-Regular",
        size : CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        self.font(.custom(fontName, size: size))
    }
    
    func setCustomFont(
        fontName: String = "Manrope-Regular",//        fontName: String = "Quicksand-Regular",
        weight: FontWeight = .regular,
        size : CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        switch weight {
            
        case .light:
//            self.font(.custom("Quicksand-Bold", size: size))
            self.font(.custom("Manrope-Regular", size: size))
        case .regular:
//            self.font(.custom("Quicksand-Regular", size: size))
            self.font(.custom("Manrope-Regular", size: size))
        case .semibold:
//            self.font(.custom("Quicksand-SemiBold", size: size))
            self.font(.custom("Manrope-Regular", size: size))
        case .medium:
//            self.font(.custom("Quicksand-Medium", size: size))
            self.font(.custom("Manrope-Regular", size: size))
        }
        
    }
}


extension View {
    func setCustomFont(
        fontName: String = "Manrope-Regular",
//        fontName: String = "Quicksand-Regular",
        size: CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> some View {
        self.font(.custom(fontName, size: size))
    }
    
    func setCustomFont(
        fontName: String = "Manrope-Regular", weight: FontWeight = .regular,
        size : CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> some View {
        switch weight {
            
        case .light:
            self.font(.custom("Manrope-Regular", size: size))
        case .regular:
            self.font(.custom("Manrope-Regular", size: size))
        case .semibold:
            self.font(.custom("Manrope-Regular", size: size))
        case .medium:
            self.font(.custom("Manrope-Regular", size: size))
        }
        
    }
}
