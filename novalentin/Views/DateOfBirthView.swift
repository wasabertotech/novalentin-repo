import SwiftUI

struct DateOfBirthView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var birthDate = Date()
    @State private var showUnderageView = false
    @State private var showNameInput = false
    
    private var minimumDate: Date {
        Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    private var age: Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }
    
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
                    Text("When's your birthday?")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Your age will be public")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Date Picker
                VStack(spacing: 8) {
                    DatePicker("Birth Date",
                              selection: $birthDate,
                              in: ...Date(),
                              displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                    
                    Text("Selected: \(dateFormatter.string(from: birthDate))")
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textSecondary)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    if age >= 18 {
                        showNameInput = true
                    } else {
                        showUnderageView = true
                    }
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
                .padding(.bottom, 20)
            }
        }
        .fullScreenCover(isPresented: $showUnderageView) {
            UnderageView()
        }
        .fullScreenCover(isPresented: $showNameInput) {
            NameInputView()
        }
    }
}

#Preview {
    DateOfBirthView()
} 