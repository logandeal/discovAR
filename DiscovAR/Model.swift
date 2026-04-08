//
//  Model.swift
//  DiscovAR
//
//  Created by Noah Wimmer on 2/26/22.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case physics
    case chemistry
    case biology
    
    var label: String {
        get {
            switch self{
            case .physics:
                return "Physics"
            case .chemistry:
                return "Chemistry"
            case .biology:
                    return "Biology - Coming Soon"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleComparison: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleComparison: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name+"_thumbnail") ?? UIImage(systemName: "photo")!
        self.scaleComparison = scaleComparison
    }
    
    func asyncLoadModelEntity() {
        let fileName = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion:  { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(fileName). Error: \(error.localizedDescription)")
                case .finished:
                    break;
                }
                
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleComparison
                
                print(fileName)
                
                print("Model: modelEntity for \(self.name) has been loaded.")
            })
    }
}

class Models {
    var all: [Model] = []
    
    init() {
        let mountain = Model(name: "mountain", category: .physics, scaleComparison: 3)
        let glucose = Model(name: "glucose", category: .chemistry, scaleComparison: 0.1)
        let volcano = Model(name: "volcano", category: .physics, scaleComparison: 1)

        
        self.all += [mountain,glucose,volcano]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}
