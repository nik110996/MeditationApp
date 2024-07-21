import SwiftUI

struct ContentView: View {
    @State private var selectedProgram: TrainingProgram? = TrainingProgram(
        name: "Strength",
        description: "Exercises for strength.",
        breathSegments: [
            BreathSegment(label: "Inhale", time: "0M 20S"),
            BreathSegment(label: "Hold", time: "0M 10S"),
            BreathSegment(label: "Exhale", time: "0M 20S"),
            BreathSegment(label: "Hold", time: "0M 10S"),
            BreathSegment(label: "Rest", time: "0M 30S")
        ])
    @AppStorage("totalTrainingTime") private var totalTrainingTime: Int = 0
    
    let programs = [
        TrainingProgram(
            name: "Strength",
            description: "Exercises for strength.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 20S"),
                BreathSegment(label: "Hold", time: "0M 10S"),
                BreathSegment(label: "Exhale", time: "0M 20S"),
                BreathSegment(label: "Hold", time: "0M 10S"),
                BreathSegment(label: "Rest", time: "0M 30S")
            ]),
        TrainingProgram(
            name: "Harmony",
            description: "Exercises for harmony.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 15S"),
                BreathSegment(label: "Hold", time: "0M 5S"),
                BreathSegment(label: "Exhale", time: "0M 15S"),
                BreathSegment(label: "Hold", time: "0M 5S"),
                BreathSegment(label: "Rest", time: "0M 20S")
            ]),
        TrainingProgram(
            name: "Anti-stress",
            description: "Exercises for stress relief.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 28S"),
                BreathSegment(label: "Hold", time: "0M 5S"),
                BreathSegment(label: "Exhale", time: "1M 3S"),
                BreathSegment(label: "Hold", time: "0M 6S"),
                BreathSegment(label: "Rest", time: "2M 0S")
            ]),
        TrainingProgram(
            name: "Anti-appetite",
            description: "Exercises to reduce appetite.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 25S"),
                BreathSegment(label: "Hold", time: "0M 8S"),
                BreathSegment(label: "Exhale", time: "1M 1S"),
                BreathSegment(label: "Hold", time: "0M 7S"),
                BreathSegment(label: "Rest", time: "1M 0S")
            ]),
        TrainingProgram(
            name: "Instead of a cigarette",
            description: "Exercises instead of smoking.",
            breathSegments: [
                BreathSegment(label: "Inhale", time: "0M 30S"),
                BreathSegment(label: "Hold", time: "0M 10S"),
                BreathSegment(label: "Exhale", time: "1M 0S"),
                BreathSegment(label: "Hold", time: "0M 10S"),
                BreathSegment(label: "Rest", time: "1M 0S")
            ])
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let selectedProgram = selectedProgram {
                        VStack {
                            Text(selectedProgram.name)
                                .font(.custom("AvenirNext-Bold", size: 34))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                .padding(.top, 40)
                            Text(selectedProgram.description)
                                .font(.custom("AvenirNext-Regular", size: 18))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                .padding(.bottom)
                            Text("Total time: \(selectedProgram.time)")
                                .font(.custom("AvenirNext-Regular", size: 18))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                .padding(.bottom)
                        }
                    } else {
                        Text("Select a program")
                            .font(.custom("AvenirNext-Bold", size: 34))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5, x: 1, y: 1)
                            .padding(.top)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if let selectedProgram = selectedProgram {
                                ForEach(selectedProgram.breathSegments) { segment in
                                    BreathSegmentView(label: segment.label, time: segment.time)
                                }
                            } else {
                                ForEach([BreathSegment(label: "Inhale", time: "0M 0S"),
                                         BreathSegment(label: "Hold", time: "0M 0S"),
                                         BreathSegment(label: "Exhale", time: "0M 0S"),
                                         BreathSegment(label: "Hold", time: "0M 0S"),
                                         BreathSegment(label: "Rest", time: "0M 0S")]) { segment in
                                    BreathSegmentView(label: segment.label, time: segment.time)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                    
                    Text("Total training time: \(formatTime(totalTrainingTime))")
                        .font(.custom("AvenirNext-Bold", size: 34))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5, x: 1, y: 1)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(programs) { program in
                                TrainingProgramView(name: program.name, time: program.time)
                                    .onTapGesture {
                                        selectedProgram = program
                                    }
                                    .background(Color.white.opacity(0.5)) // Полупрозрачный фон для каждого элемента
                                    .padding(.vertical, 10) // Добавим небольшое вертикальное расстояние между элементами
                            }
                        }
                    }
                    
                    if selectedProgram != nil {
                        NavigationLink(destination: TrainingView(program: selectedProgram!, totalTrainingTime: $totalTrainingTime)) {
                            Text("Start training")
                                .font(.custom("AvenirNext-Bold", size: 20))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 50)
                    }
                }
            }
        }
    }
    
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct BreathSegmentView: View {
    var label: String
    var time: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.custom("AvenirNext-Medium", size: 25))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5, x: 1, y: 1)
            Text(time)
                .font(.custom("AvenirNext-Medium", size: 20))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5, x: 1, y: 1)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .frame(minWidth: 100)
    }
}

struct TrainingProgramView: View {
    var name: String
    var time: String
    
    var body: some View {
        HStack {
            Image(systemName: "lungs.fill")
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.custom("AvenirNext-Bold", size: 25))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 1, y: 1)
                Text(time)
                    .font(.custom("AvenirNext-Medium", size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
            }
            Spacer()
            Image(systemName: "rosette")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
