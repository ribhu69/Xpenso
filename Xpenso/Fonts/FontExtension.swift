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
        fontName: String = "Quicksand-Regular",
        size : CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        self.font(.custom(fontName, size: size))
    }
    
    func setCustomFont(
        fontName: String = "Quicksand-Regular", weight: FontWeight = .regular,
        size : CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    ) -> Text {
        switch weight {
            
        case .light:
            self.font(.custom("Quicksand-Bold", size: size))
        case .regular:
            self.font(.custom("Quicksand-Regular", size: size))
        case .semibold:
            self.font(.custom("Quicksand-SemiBold", size: size))
        case .medium:
            self.font(.custom("Quicksand-Medium", size: size))
        }
        
    }
}
