//
//  ContentView.swift
//  RealityListener
//
//  Created by Morten Just on 5/21/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let speaker01 = try! Experience.loadSpeaker01()
        let speaker02 = try! speaker01.findEntity(named: "Speaker02")!
        
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(speaker01)
        
        addAudio(withName: "steve01.wav", to: speaker01)
        addAudio(withName: "woz01.wav", to: speaker02)
  
        
        return arView
        
    }
    
    func addAudio(withName name: String, to entity : Entity) {
        
        do {
            let resource = try AudioFileResource.load(named: name)
            resource.loadingStrategy = .preload
            resource.shouldLoop = true
            resource.inputMode = .spatial
            
            let audioController = entity.prepareAudio(resource)
            
            print("playing")
            audioController.play()
            
        } catch {
            print("can't load: ", error.localizedDescription)
        }
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
