//
//  CurrentLocationViewModel.swift
//  Sky
//
//  Created by Qing ’s on 2019/1/31.
//  Copyright © 2019 Qing's. All rights reserved.
//

import Foundation

struct CurrentLocationViewModel{
    var location: Location
    
    static let empty = CurrentLocationViewModel(location: Location.empty)
    
    // 位置
    var city: String {
        return location.name
    }

    var isEmpty: Bool {
        return self.location == Location.empty
    }
    
    static let invalid =
        CurrentLocationViewModel(location: .invalid)
    
    var isInvalid: Bool {
        return self.location == Location.invalid
    }
}
