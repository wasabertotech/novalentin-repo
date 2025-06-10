import SwiftUI

struct WelcomeView: View {
    @State private var phoneNumber = ""
    @State private var showVerification = false
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = number.filter { $0.isNumber }
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
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // App Logo
                    Image(systemName: "square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(AppColors.navarraBlue)
                        .padding(.top, 60)
                    
                    // Welcome Text
                    VStack(spacing: 16) {
                        Text("Welcome to NoValentin")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Find your perfect match")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    // Phone Input
                    VStack(spacing: 20) {
                        HStack {
                            Text("+1")
                                .foregroundColor(AppColors.textPrimary)
                                .font(.system(size: 17, weight: .medium))
                            
                            TextField("(123) 456 - 7890", text: $phoneNumber)
                                .keyboardType(.numberPad)
                                .font(.system(size: 17))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                .onChange(of: phoneNumber) { newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    if filtered.count > 10 {
                                        phoneNumber = String(filtered.prefix(10))
                                    }
                                    phoneNumber = formatPhoneNumber(filtered)
                                }
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {
                            showVerification = true
                        }) {
                            Text("Continue")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(AppColors.buttonText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColors.buttonBackground)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .disabled(phoneNumber.filter { $0.isNumber }.count != 10)
                        .opacity(phoneNumber.filter { $0.isNumber }.count != 10 ? 0.6 : 1)
                    }
                    
                    Spacer()
                    
                    // Terms and Privacy
                    Text("By continuing, you agree to our Terms of Service and Privacy Policy")
                        .font(.system(size: 13))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showVerification) {
                VerificationView(phoneNumber: phoneNumber)
            }
        }
    }
}

#Preview {
    WelcomeView()
} 