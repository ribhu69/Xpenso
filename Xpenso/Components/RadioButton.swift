//
//  RadioButton.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding var selection: Bool

    var body: some View {
        ZStack {
            Circle()  // Background circle
                .stroke(Color.gray, lineWidth: 1.5)

            if selection {  // Show tick only when selected
                Image("tick", bundle: nil)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
//                    .foregroundStyle(Color.white)
                    
                    
            }
        }
        .contentShape(Circle())
        .onTapGesture {  // Add tap gesture action
            selection.toggle()  // Toggle selection on tap
        }
    }
}



//struct RadioButton_PV: PreviewProvider {
//    static var previews: some View {
////        RadioButton(selection: .constant(true))
//    }
//}
