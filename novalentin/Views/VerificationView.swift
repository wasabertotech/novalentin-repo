import SwiftUI

struct VerificationView: View {
    let phoneNumber: String
    @Environment(\.dismiss) private var dismiss
    @State private var verificationCode = ""
    @State private var timeRemaining = 60
    @State private var isResendEnabled = false
    @State private var showDateOfBirth = false
    @FocusState private var isInputFocused: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(AppColors.textPrimary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 16) {
                    Text("Verification Code")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("We've sent a verification code to\n\(phoneNumber)")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Verification Code Input
                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        let digit = index < verificationCode.count ? String(verificationCode[verificationCode.index(verificationCode.startIndex, offsetBy: index)]) : ""
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 50, height: 60)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(isInputFocused ? AppColors.navarraBlue : AppColors.navarraBlue.opacity(0.3), lineWidth: isInputFocused ? 2 : 1)
                                )
                            
                            Text(digit)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                        }
                        .onTapGesture {
                            isInputFocused = true
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Hidden TextField for keyboard input
                TextField("", text: $verificationCode)
                    .keyboardType(.numberPad)
                    .focused($isInputFocused)
                    .frame(width: 0, height: 0)
                    .opacity(0)
                    .onChange(of: verificationCode) { _, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered != newValue {
                            verificationCode = filtered
                        }
                        if filtered.count > 6 {
                            verificationCode = String(filtered.prefix(6))
                        }
                    }
                
                // Resend Timer
                HStack(spacing: 4) {
                    Text("Didn't receive the code?")
                        .foregroundColor(AppColors.textSecondary)
                    
                    if isResendEnabled {
                        Button(action: {
                            resendCode()
                        }) {
                            Text("Resend")
                                .foregroundColor(AppColors.navarraBlue)
                                .fontWeight(.medium)
                        }
                    } else {
                        Text("Wait \(timeRemaining)s")
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
                .font(.system(size: 15))
                .padding(.top, 20)
                
                // Verify Button
                Button(action: {
                    verifyCode()
                }) {
                    Text("Verify")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppColors.buttonText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(verificationCode.count == 6 ? AppColors.buttonBackground : AppColors.buttonBackground.opacity(0.6))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                .disabled(verificationCode.count != 6)
                
                Spacer()
            }
        }
        .onAppear {
            isInputFocused = true
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isResendEnabled = true
            }
        }
        .fullScreenCover(isPresented: $showDateOfBirth) {
            DateOfBirthView()
        }
    }
    
    private func resendCode() {
        // TODO: Implement resend code functionality
        timeRemaining = 60
        isResendEnabled = false
    }
    
    private func verifyCode() {
        // TODO: Implement actual verification functionality
        // For now, we'll just simulate a successful verification
        showDateOfBirth = true
    }
}

#Preview {
    VerificationView(phoneNumber: "+1 (234) 567-8900")
} 