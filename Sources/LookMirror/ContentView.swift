import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @StateObject private var settingsManager = SettingsManager()
    
    var body: some View {
        VStack {
            if cameraManager.isAuthorized {
                ZStack(alignment: .topLeading) {
                    CameraView(cameraManager: cameraManager)
                        .scaleEffect(x: settingsManager.isMirrored ? -1 : 1, y: 1)
                        .frame(width: settingsManager.selectedAspectRatio.size.width,
                               height: settingsManager.selectedAspectRatio.size.height)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    
                    Menu {
                        Section("General") {
                            Toggle("Mirror My Video", isOn: $settingsManager.isMirrored)
                        }
                        
                        Section("Aspect Ratio") {
                            ForEach(AspectRatio.allCases) { ratio in
                                Button {
                                    settingsManager.selectedAspectRatio = ratio
                                } label: {
                                    if ratio == settingsManager.selectedAspectRatio {
                                        Label(ratio.rawValue, systemImage: "checkmark")
                                    } else {
                                        Text(ratio.rawValue)
                                    }
                                }
                            }
                        }
                        
                        Section("Video Effects") {
                            Button("System Panel...") {
                                AVCaptureDevice.showSystemUserInterface(.videoEffects)
                            }
                        }
                                                
                        Divider()
                        
                        Button("Quit LookMirror") {
                            NSApplication.shared.terminate(nil)
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .padding(16)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .menuStyle(.borderlessButton)
                    .padding(16)
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "camera.fill.badge.ellipsis")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("Camera Access Required")
                        .font(.headline)
                    Text("Please grant permission to use the camera.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Button("Open Settings") {
                        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Camera") {
                            NSWorkspace.shared.open(url)
                        }
                    }
                }
                .frame(width: 300, height: 400)
                .background(Color(nsColor: .windowBackgroundColor))
            }
        }
        .padding(12)
    }
}
