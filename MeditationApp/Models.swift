import Foundation

struct TrainingProgram: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var breathSegments: [BreathSegment]
    
    var time: String {
        let totalSeconds = breathSegments.reduce(0) { $0 + $1.totalSeconds }
        return formatTime(totalSeconds)
    }
    
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct BreathSegment: Identifiable {
    let id = UUID()
    var label: String
    var time: String
    
    var totalSeconds: Int {
        let components = time.split(separator: "M").map { String($0) }
        guard components.count == 2,
              let minutes = Int(components[0].trimmingCharacters(in: .whitespacesAndNewlines)),
              let seconds = Int(components[1].trimmingCharacters(in: .whitespacesAndNewlines).dropLast()) else {
            return 0
        }
        return (minutes * 60) + seconds
    }
}
