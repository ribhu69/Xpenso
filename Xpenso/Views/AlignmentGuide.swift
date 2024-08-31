//
//  AlignmentGuide.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 29/08/24.
//

import SwiftUI

struct AlignmentGuide : View {
    var body: some View {
        HStack(alignment: .bottom) {
            Rectangle()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                .foregroundStyle(.red)
                .alignmentGuide(.top) {
                    _ in
                    -60
                }
            
            Rectangle()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                .foregroundStyle(.blue)
        }
        .border(.gray)
    }
}

#Preview {
    AlignmentGuide()
}
