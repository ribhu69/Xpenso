//
//  ContentView.swift
//  XpensoMac
//
//  Created by Arkaprava Ghosh on 10/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("underConstruction", bundle: nil)
                .renderingMode(.template)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.secondary)
            Text("We are in the works :)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
