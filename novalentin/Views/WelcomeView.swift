import SwiftUI

struct WelcomeView: View {
    @State private var phoneNumber = ""
    @State private var showVerification = false
    @State private var isAnimating = false
    
    // Navy blue color palette
    private let navyBlue = Color(red: 0.06, green: 0.12, blue: 0.24)
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = String(number.filter { $0.isNumber }.prefix(10))
        var result = ""
        
        for (index, char) in cleaned.enumerated() {
            if index == 0 {
                result.append("(")
            }
            if index == 3 {
                result.append(") ")
            }
            if index == 6 {
                result.append(" - ")
            }
            result.append(char)
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Base background
                    navyBlue.ignoresSafeArea()
                    
                    // Main content
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 40) {
                            // Logo and branding section
                            VStack(spacing: 30) {
                                // Logo
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                    .frame(height: 80)
                                
                                // Brand text
                                VStack(spacing: 12) {
                                    Text("NOVALENTIN")
                                        .font(.system(size: 32, weight: .bold))
                                        .kerning(8)
                                        .foregroundColor(.white)
                                    
                                    Text("A Different Dating App")
                                        .font(.custom("Zapfino", size: 16))
                                        .foregroundColor(.white)
                                }
                                .offset(y: isAnimating ? 0 : 20)
                                .opacity(isAnimating ? 1 : 0)
                            }
                            .padding(.top, 60)
                            
                            // Input section
                            VStack(spacing: 24) {
                                // Phone input
                                HStack(spacing: 12) {
                                    // Country code
                                    HStack(spacing: 8) {
                                        Text("🇺🇸")
                                            .font(.system(size: 18))
                                        Text("+1")
                                            .font(.system(size: 16, weight: .medium))
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 75)
                                    .frame(height: 50)
                                    .background(Color.white.opacity(0.05))
                                    .overlay(
                                        Rectangle()
                                            .fill(Color.white.opacity(0.1))
                                            .frame(height: 1),
                                        alignment: .bottom
                                    )
                                    
                                    // Phone field
                                    TextField("(123) 456 - 7890", text: $phoneNumber)
                                        .keyboardType(.numberPad)
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .frame(height: 50)
                                        .padding(.horizontal)
                                        .background(Color.white.opacity(0.05))
                                        .overlay(
                                            Rectangle()
                                                .fill(Color.white.opacity(0.1))
                                                .frame(height: 1),
                                            alignment: .bottom
                                        )
                                        .onChange(of: phoneNumber) { newValue in
                                            let filtered = newValue.filter { $0.isNumber }
                                            if filtered.count > 10 {
                                                phoneNumber = formatPhoneNumber(String(filtered.prefix(10)))
                                            } else {
                                                phoneNumber = formatPhoneNumber(filtered)
                                            }
                                        }
                                }
                                .padding(.horizontal, 20)
                                
                                // Continue button
                                Button(action: {
                                    showVerification = true
                                }) {
                                    HStack {
                                        Text("CONTINUE")
                                            .font(.system(size: 15, weight: .bold))
                                            .kerning(2)
                                        
                                        if phoneNumber.filter({ $0.isNumber }).count == 10 {
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 15, weight: .bold))
                                                .transition(.opacity)
                                        }
                                    }
                                    .foregroundColor(navyBlue)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .opacity(phoneNumber.filter({ $0.isNumber }).count == 10 ? 1 : 0.7)
                                }
                                .padding(.horizontal, 20)
                                .disabled(phoneNumber.filter { $0.isNumber }.count != 10)
                            }
                            
                            Spacer()
                            
                            // Terms section
                            VStack(spacing: 12) {
                                Text("By continuing you agree to our")
                                    .foregroundColor(Color.white.opacity(0.5))
                                
                                HStack(spacing: 4) {
                                    Button(action: { /* Terms action */ }) {
                                        Text("Terms of Service")
                                            .underline()
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text("and")
                                        .foregroundColor(Color.white.opacity(0.5))
                                    
                                    Button(action: { /* Privacy action */ }) {
                                        Text("Privacy Policy")
                                            .underline()
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .font(.system(size: 13))
                            .kerning(0.5)
                            .padding(.bottom, 30)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showVerification) {
                VerificationView(phoneNumber: phoneNumber)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    isAnimating = true
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
} 