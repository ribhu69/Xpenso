import SwiftUI

struct AddBudgetView : View {
    
    @State private var overallSelected: Bool = true
    @State private var categorySelected: Bool = false
    @State private var desc: String = "You set a total spending limit for a specific period (e.g., monthly, yearly) to help manage your finances by capping overall expenses and ensuring you stay within your financial means."
    @State private var animationEnabled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose a budget type")
                .font(.title)
                .padding(.bottom, 8)
            
            Text(desc)
                .font(.title3)
                .foregroundStyle(Color.secondary)
                .padding(.bottom, 8)
                .animation(.snappy(duration: 0.5)) // Animation
            
            HStack {
                Text("Overall budget")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(uiColor: overallSelected ? .systemGreen : .secondarySystemBackground), lineWidth: 2)
                    )
                    .onTapGesture {
                        withAnimation {
                            overallSelected = true
                            categorySelected = false
                            animationEnabled.toggle() // Toggle animation
                            updateDescription()
                        }
                    }
                
                Text("Category budget")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(uiColor: categorySelected ? .systemGreen : .secondarySystemBackground), lineWidth: 2)
                    )
                    .onTapGesture {
                        withAnimation {
                            overallSelected = false
                            categorySelected = true
                            animationEnabled.toggle() // Toggle animation
                            updateDescription()
                        }
                    }
            }
            .padding(.top, 16)
            Spacer()
            
            HStack {
                Spacer()
                Text("Proceed")
                    .padding()
                Spacer()
                    
//                    .onTapGesture {
//                        withAnimation {
//                            overallSelected = false
//                            categorySelected = true
//                            animationEnabled.toggle() // Toggle animation
//                            updateDescription()
//                        }
//                    }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(uiColor: categorySelected ? .systemGreen : .secondarySystemBackground), lineWidth: 2)
                    .backgroundStyle(Color.green)
            )
            
        }
        .padding(.horizontal, 8)
    }
    
    func updateDescription() {
        desc = overallSelected ? "You set a total spending limit for a specific period (e.g., monthly, yearly) to help manage your finances by capping overall expenses and ensuring you stay within your financial means." : "You allocate specific spending limits to different categories (e.g., food, travel) to help control and track expenses in each area, promoting better financial discipline and awareness"
    }
}

#Preview {
    AddBudgetView()
}
