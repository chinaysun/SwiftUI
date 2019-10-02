//
//  UserData.swift
//  Landmarks
//
//  Created by Yu Sun on 3/10/19.
//  Copyright © 2019 Yu Sun. All rights reserved.
//

import Combine

final class UserData: ObservableObject  {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
