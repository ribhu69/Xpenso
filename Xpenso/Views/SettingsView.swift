//
//  SettingsView.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 27/08/24.
//

import Foundation
import SwiftUI

class AppTheme: ObservableObject {
    static let shared = AppTheme()
    @Published var selectedColor : Color!
    var selectedColorString = AppDefaults.shared.getValue(for: AppConstants.appThemeColor.rawValue) as? String ?? "blue"
    private init() {
        selectedColor = ColorOption(stringValue: selectedColorString)!.color
    }

}

struct SettingsView: View {
    
    private var appVersion: String {
        let infoDictionary = Bundle.main.infoDictionary
        let version = infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return version
    }
    
    @State var selectedColor = AppTheme.shared.selectedColor
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: UIFont.labelFontSize)!
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Manrope-Regular", size: 34)!
        ]
        appearance.backgroundColor = UIColor.systemBackground
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) { // Align VStack to leading and set spacing
                        Text("Choose App Theme Color")
                            .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(ColorOption.allCases, id: \.self) { colorOption in
                                    
                                    
                                    Circle().fill(colorOption.color)
                                        .frame(width: 40, height: 40)
                                        .padding(.horizontal, 4)
                                        .onTapGesture {
                                            if selectedColor != colorOption.color {
                                                selectedColor = colorOption.color
                                                
                                                AppTheme.shared.selectedColor = selectedColor
                                                AppTheme.shared.selectedColorString = colorOption.rawValue
                                                AppDefaults.shared.setValue(key: AppConstants.appThemeColor.rawValue, value: AppTheme.shared.selectedColorString)
                                            }
                                            
                                        }
                                        .overlay {
                                            if colorOption.color == selectedColor {
                                                Circle().stroke(Color.secondary, lineWidth: 2)
                                            }
                                        }
                                }
                                
                            }.padding(.vertical, 8)
                        }
                      
                        Text("App Version")
                            .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                            .padding(.bottom, 8)
                        Text("\(appVersion)")
                            .setCustomFont()
                            .foregroundStyle(.secondary)
                        
                        Link(destination: URL(string: "https://github.com/ribhu69/Xpenso")!) {
                            Text("@Xpenso")
                                .setCustomFont(size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
                        }
                        .padding(.top, 16)
                        
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                
                
            }
            .navigationTitle("Settings")
        }
    }
}

enum ColorOption: String, CaseIterable {
    case red, gold, teal, blue, orange, salmon
    
    var color: Color {
        switch self {
            
        case .red:
            return .crimson
        case .gold:
            return .luxuryGold
        case .teal:
            return .richTeal
        case .blue:
            return .royalBlue
        case .orange:
            return .tangeringOrange
        case .salmon:
            return .salmon
        }
    }
    
    init?(stringValue: String) {
        switch stringValue {
        case "crimson" :
            self.init(rawValue: stringValue)
        case "gold" :
            self.init(rawValue: stringValue)
        case "teal" :
            self.init(rawValue: stringValue)
        case "blue" :
            self.init(rawValue: stringValue)
        case "orange" :
            self.init(rawValue: stringValue)
        case "salmon" :
            self.init(rawValue: stringValue)
        default:
            self.init(rawValue: "blue")
       
        }
    }
}

#Preview {
    SettingsView()
}
