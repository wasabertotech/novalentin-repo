import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var subscriptionManager = SubscriptionManager.shared
    @State private var showMainTab = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header
                    Text("One Last Step")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.top, 40)
                    
                    // Subscription Box
                    VStack(spacing: 16) {
                        // Trial Badge
                        HStack {
                            Text("7 DAYS FREE")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(AppColors.navarraBlue)
                                .cornerRadius(20)
                        }
                        
                        // Price
                        Text("$1.00")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        Text("per month")
                            .font(.system(size: 16))
                            .foregroundColor(AppColors.textSecondary)
                        
                        // Features
                        VStack(alignment: .leading, spacing: 12) {
                            FeatureRow(text: "Unlimited matches")
                            FeatureRow(text: "Advanced filters")
                            FeatureRow(text: "Priority support")
                            FeatureRow(text: "Ad-free experience")
                        }
                        .padding(.top, 20)
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 10)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Buttons
                    VStack(spacing: 16) {
                        Button(action: {
                            isLoading = true
                            // Start the trial
                            subscriptionManager.startTrial()
                            // Simulate subscription process
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isLoading = false
                                showMainTab = true
                            }
                        }) {
                            ZStack {
                                Text("Start Free Trial")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(AppColors.buttonText)
                                    .opacity(isLoading ? 0 : 1)
                                
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: AppColors.buttonText))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.buttonBackground)
                            .cornerRadius(12)
                        }
                        .disabled(isLoading)
                        
                        Button(action: {
                            // Exit the app
                            exit(0)
                        }) {
                            Text("No Thanks")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(AppColors.textSecondary)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                    
                    // Terms
                    Text("Subscription auto-renews for $1.00/month after trial. Cancel anytime.")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showMainTab) {
                NameInputView()
            }
        }
    }
}

struct FeatureRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(AppColors.navarraBlue)
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(AppColors.textPrimary)
        }
    }
}

#Preview {
    SubscriptionView()
} 