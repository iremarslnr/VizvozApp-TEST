//
//  audioRec.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 16/12/24.
//

import SwiftUI
import AVFoundation

struct VoiceRecorderApp: View {
    @StateObject private var audioRecorder = AudioRecorder()
    
    var body: some View {
        NavigationView {
            VStack {
                if audioRecorder.isRecording {
                    Button(action: audioRecorder.stopRecording) {
                        Text("Stop Recording")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .accessibilityLabel("Stop Recording, button")
                            .accessibilityHint("Tap to   stop recording")
                    }
                } else {
                    Button(action: audioRecorder.startRecording) {
                        Text("Start Recording")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .accessibilityLabel("Start Recording, button")
                            .accessibilityHint("Tap to   start recording")
                    }
                }
                
                List {
                    ForEach(audioRecorder.recordings, id: \.id) { recording in
                        HStack {
                            Text(recording.fileName)
                                .lineLimit(1)
                            Spacer()
                            Button(action: {
                                audioRecorder.playRecording(recording: recording)
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title)
                            }
                        }
                    }
                    .onDelete(perform: audioRecorder.deleteRecording)
                }
                .navigationTitle("All Recordings")
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .onAppear {
            audioRecorder.loadRecordings()
        }
    }
}


class AudioRecorder: ObservableObject {
    @Published var isRecording = false
    @Published var recordings: [Recording] = []
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let fileName = UUID().uuidString + ".m4a"
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.record()
            
            isRecording = true
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        
        loadRecordings()
    }
    
    func loadRecordings() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        
        do {
            let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            recordings = files.map { Recording(fileURL: $0) }
        } catch {
            print("Failed to load recordings: \(error.localizedDescription)")
        }
    }
    
    func playRecording(recording: Recording) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: recording.fileURL)
            audioPlayer?.play()
            UIAccessibility.post(notification: .announcement, argument: "Play the recording.")
        } catch {
            print("Failed to play recording: \(error.localizedDescription)")
        }
    }
    
    func deleteRecording(at offsets: IndexSet) {
        for index in offsets {
            let recording = recordings[index]
            do {
                try FileManager.default.removeItem(at: recording.fileURL)
                recordings.remove(at: index)
            } catch {
                print("Failed to delete recording: \(error.localizedDescription)")
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


struct Recording: Identifiable {
    let id = UUID()
    let fileURL: URL
    
    var fileName: String {
        fileURL.lastPathComponent
    }
}


struct VoiceRecorderApp_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecorderApp()
    }
}
