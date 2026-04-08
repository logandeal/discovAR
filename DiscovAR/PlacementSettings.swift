//
//  PlacementSettings.swift
//  DiscovAR
//
//  Created by Noah Wimmer on 2/26/22.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    @Published var selectedModel: Model? {
        // When the user selects a model in BrowseView, this property is set.
        willSet(newValue) {
            print("PlacementSettings: Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    
    // When the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel.
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("PlacementSettings: Clearing confirmedModel")
                return
            }
            
            print("PlacementSettings: Setting confirmedModel to \(model.name)")
        }
    }
    
    // This property retains the cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
    
}
