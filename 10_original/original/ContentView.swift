import SwiftUI

struct ContentView: View {

    @State private var timer: Timer?
    @State private var secondsElapsed: Double = 0.0
    @State private var isRunning = false
    @State private var laps: [Double] = []

    var body: some View {
        VStack(spacing: 20) {
            Text(String(format: "%.2f", secondsElapsed))
                .font(.system(size: 50, weight: .bold, design: .rounded))

            HStack(spacing: 30) {
                if isRunning {
                    Button {
                        pause()
                    } label: {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                } else {
                    Button {
                        start()
                    } label: {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }

                if secondsElapsed != 0.0 {
                    Button {
                        stop()
                    } label: {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }

                if isRunning {
                    Button {
                        recordLap()
                    } label: {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
            Group {
                if !laps.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Laps")
                            .font(.headline)
                        ScrollView {
                            ForEach(Array(laps.enumerated()), id: \.offset) { index, lap in
                                Text("Lap \(index + 1): \(String(format: "%.2f", lap))s")
                                    .padding(.vertical, 2)
                            }
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .frame(height: 150)

        }
        .padding()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            secondsElapsed += 0.1
        }
        isRunning = true
    }

    func pause() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        secondsElapsed = 0.0
        laps.removeAll()
    }

    func recordLap() {
        laps.append(secondsElapsed)
    }
}

#Preview {
    ContentView()
}

