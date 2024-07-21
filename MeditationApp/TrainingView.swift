import SwiftUI

struct TrainingView: View {
    var program: TrainingProgram
    @Binding var totalTrainingTime: Int
    @State private var currentSegmentIndex = 0
    @State private var remainingTime: Int = 0
    @State private var timer: Timer?
    @State private var elapsedTime: Int = 0

    var body: some View {
        ZStack {
            Image("Background2")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(program.name)
                    .font(.custom("AvenirNext-Bold", size: 34))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 1, y: 1)
                    .padding(.top)
                
                Text("Total time: \(program.time)")
                    .font(.custom("AvenirNext-Regular", size: 25))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 1, y: 1)
                    .padding(.bottom, 220)

                if currentSegmentIndex < program.breathSegments.count {
                    let segment = program.breathSegments[currentSegmentIndex]
                    Text(segment.label)
                        .font(.custom("AvenirNext-Bold", size: 34))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .padding(.top)
                    Text("\(formatTime(remainingTime))")
                        .font(.custom("AvenirNext-Bold", size: 35))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .padding(.bottom)
                    Button(action: {
                        startTimer()
                    }) {
                        Text("Start")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Text("Training completed")
                        .font(.custom("AvenirNext-Bold", size: 34))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .padding(.top)
                }
            }
            .onAppear {
                if program.breathSegments.count > 0 {
                    remainingTime = parseTime(program.breathSegments[currentSegmentIndex].time)
                }
            }
            .onDisappear {
                timer?.invalidate()
                totalTrainingTime += elapsedTime
            }
        }
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.elapsedTime += 1
            } else {
                self.moveToNextSegment()
            }
        }
    }

    func moveToNextSegment() {
        if currentSegmentIndex < program.breathSegments.count - 1 {
            currentSegmentIndex += 1
            remainingTime = parseTime(program.breathSegments[currentSegmentIndex].time)
        } else {
            timer?.invalidate()
            totalTrainingTime += elapsedTime
        }
    }

    func parseTime(_ time: String) -> Int {
        let components = time.split(separator: "M").map { String($0) }
        guard let minutes = Int(components[0].trimmingCharacters(in: .whitespacesAndNewlines)),
              let seconds = Int(components[1].trimmingCharacters(in: .whitespacesAndNewlines).dropLast()) else {
            return 0
        }
        return (minutes * 60) + seconds
    }

    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(program: TrainingProgram(
            name: "Anti-stress",
            description: "Exercises for stress relief.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 28S"),
                BreathSegment(label: "Hold", time: "0M 5S"),
                BreathSegment(label: "Exhale", time: "1M 3S"),
                BreathSegment(label: "Hold", time: "0M 6S"),
                BreathSegment(label: "Rest", time: "2M 0S")
            ]),
            totalTrainingTime: .constant(0)
        )
    }
}
