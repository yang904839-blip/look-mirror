import SwiftUI

enum AspectRatio: String, CaseIterable, Identifiable {
    case ratio16_9 = "16:9"
    case ratio9_16 = "9:16"
    case ratio3_4 = "3:4"
    case ratio4_3 = "4:3"
    case ratio1_1 = "1:1"
    
    var id: String { self.rawValue }
    
    var size: CGSize {
        switch self {
        case .ratio16_9: return CGSize(width: 480, height: 270)
        case .ratio9_16: return CGSize(width: 270, height: 480)
        case .ratio3_4: return CGSize(width: 300, height: 400)
        case .ratio4_3: return CGSize(width: 400, height: 300)
        case .ratio1_1: return CGSize(width: 350, height: 350)
        }
    }
}

class SettingsManager: ObservableObject {
    @AppStorage("selectedAspectRatio") var selectedAspectRatio: AspectRatio = .ratio16_9
    @AppStorage("isMirrored") var isMirrored: Bool = true
}

// Extension to support storing Enum in AppStorage
extension AspectRatio: RawRepresentable {
    // String raw value is sufficient
}
