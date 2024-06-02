import SwiftUI

struct Kalimba : View {
    var body : some View {
        VStack {
            Image("rocket", bundle: nil)
                .resizable()
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.secondary)
            Text("Hang in there slick!! Our devs are working on this :)")
                .font(.title3)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center) // Center align text
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Center align VStack in the parent
    }
}

#Preview {
    Kalimba()
}
