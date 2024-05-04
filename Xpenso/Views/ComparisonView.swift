//
//  ComparisonView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 04/05/24.
//

import SwiftUI


struct ComparisonView : View {
    @Binding var comparisonType : Comparison
    @Binding var isPresented: Bool
    var body: some View {
            VStack {
                
               
                List {
                    ForEach(Comparison.allCases, id: \.id) { item in
                        ComparisonRow(comparison: item)
                        .onTapGesture {
                            self.comparisonType = item
                            isPresented = false
                        }
                    }
                    
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
            }
    }
}

struct ComparisonRow : View {
    var comparison: Comparison
    var body: some View {
        HStack {
            Image(comparison.rawValue, bundle: nil)
                .renderingMode(.template)
            Text(comparison.displayValue)
        }
        .padding(.vertical, 8)
    }
}

struct ComparisonView_PV: PreviewProvider {
    static var previews: some View {
        ComparisonView(comparisonType: .constant(.equalTo), isPresented: .constant(false))
    }
}
