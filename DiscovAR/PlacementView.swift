//
//  PlacementView.swift
//  DiscovAR
//
//  Created by Noah Wimmer on 2/26/22.
//

import SwiftUI

struct PlacementView : View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body : some View {
        HStack {
            
            Spacer()
            
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("PlacementView: Cancel Placement Button Pressed.")
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
            
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("PlacementView: Confirm Placement Model Button Pressed.")
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                self.placementSettings.selectedModel = nil
            }
            
            Spacer()
        }
    }
}

struct PlacementButton : View {
    let systemIconName: String
    let action: () -> Void
        
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
        
    }
}
