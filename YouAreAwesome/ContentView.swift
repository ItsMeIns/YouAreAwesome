//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by macbook on 17.10.2022.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var messageString = ""
    @State private var imageName = ""
    @State private var lastMessageNumber = -1
    @State private var lastImageNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var lastSoundNumber = -1
    @State private var soundName = ""
    @State private var soundIsOn = true
    
    var body: some View {
        
        
        VStack  {
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(.pink)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
                .animation(.easeInOut(duration: 0.15), value: messageString)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .shadow(radius: 30)
                .padding()
                .animation(.default, value: messageString)
            
            
            
            Spacer()
            
            
            
            
            HStack {
                Text("Sound: \(soundIsOn ? "on" : "off")")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) { _ in
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                            
                        }
                    }
                    
                
                
                Spacer()
                
                
                Button("Show Massage") {
                    
                    
                    let messages = ["Ти крутий",
                                    "Красень!",
                                    "Спробуй ще і в тебе все вийде",
                                    "Непогано, але ти можеш краще",
                                    "В тебе добре виходить і ти швидко навчаєшся!"]
                    // text
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    messageString = messages[lastMessageNumber]
                    
                    
                    // image
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBound: 9)
                    imageName = "image\(lastImageNumber)"
                    
                    
                    // sound
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBound: 5)
                    soundName = "sound\(lastSoundNumber)"
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                        
                    }
                    
                    
                    
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
            }
            
            .tint(.accentColor)
        }
        .padding()
        
        
    }
    
    func nonRepeatingRandom(lastNumber: Int, upperBound: Int) -> Int {
        
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperBound)
            
        } while newNumber == lastNumber
        return newNumber
    }
    
    
    
    func playSound (soundName: String) {
        
        
        guard let soundFile = NSDataAsset(name: soundName) else
        {
            print(" Cant open file \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print(" ERROR : \(error.localizedDescription)")
        }
    }
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
