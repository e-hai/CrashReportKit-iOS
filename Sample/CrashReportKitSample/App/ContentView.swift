import SwiftUI
import CrashReportKit

enum SampleError: LocalizedError {
    case simulatedNetworkFailure
    case invalidState(code: Int)

    var errorDescription: String? {
        switch self {
        case .simulatedNetworkFailure:
            return "Simulated Network Request Failure (Non-fatal)"
        case .invalidState(let code):
            return "Simulated Invalid State Error with code \(code)"
        }
    }
}

struct ContentView: View {
    @State private var toastMessage: String?
    @State private var counter: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("CrashReportKit iOS Demo")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 24)

                Text("Business layer depends solely on CrashReport facade.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Divider().padding(.vertical, 8)

                VStack(spacing: 16) {
                    Button(action: recordBreadcrumb) {
                        Label("Log Breadcrumb", systemImage: "text.bubble")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: recordNonFatalException) {
                        Label("Record Non-Fatal Exception", systemImage: "exclamationmark.triangle")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: updateCustomKeys) {
                        Label("Update Custom Keys (Count: \(counter))", systemImage: "tag")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(role: .destructive, action: triggerFatalCrash) {
                        Label("Test Fatal Crash (fatalError)", systemImage: "xmark.octagon")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 24)

                if let message = toastMessage {
                    Text(message)
                        .font(.footnote)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .transition(.opacity)
                }

                Spacer()
            }
            .navigationTitle("CrashReportKit")
        }
    }

    private func recordBreadcrumb() {
        CrashReport.log("User tapped breadcrumb button at \(Date())")
        showToast("Logged breadcrumb")
    }

    private func recordNonFatalException() {
        CrashReport.recordException(SampleError.simulatedNetworkFailure)
        showToast("Recorded non-fatal exception")
    }

    private func updateCustomKeys() {
        counter += 1
        CrashReport.setCustomKey("tap_counter", value: counter)
        CrashReport.setCustomKey("last_action_timestamp", value: Double(Date().timeIntervalSince1970))
        showToast("Updated custom keys (counter=\(counter))")
    }

    private func triggerFatalCrash() {
        CrashReport.log("Fatal crash button triggered")
        CrashReport.testCrash()
    }

    private func showToast(_ text: String) {
        withAnimation {
            toastMessage = text
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                if toastMessage == text {
                    toastMessage = nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
