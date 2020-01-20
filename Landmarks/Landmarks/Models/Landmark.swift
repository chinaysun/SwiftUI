//
//  Landmark.swift
//  Landmarks
//
//  Created by Yu Sun on 1/10/19.
//  Copyright © 2019 Yu Sun. All rights reserved.
//
//  Added some commands
//  More commands in

import SwiftUI
import CoreLocation

struct Coordinates: Codable {

    let latitude: Double
    let longitude: Double
}

struct Landmark: Codable, Identifiable {
    
    let id: Int
    let name: String
    fileprivate let imageName: String
    fileprivate let coordinates: Coordinates
    let state: String
    let park: String
    let category: Category
    var isFavorite: Bool
    var isFeatured: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

extension Landmark {
    
    enum Category: String, CaseIterable, Codable, Hashable {

        case featured = "Mountains"
        case lakes = "Lakes"
        case rivers = "Rivers"
    }
}

extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
