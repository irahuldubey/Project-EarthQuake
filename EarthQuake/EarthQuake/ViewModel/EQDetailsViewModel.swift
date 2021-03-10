//
//  EQDetailsViewModel.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

struct EQDetailsViewModel {
    
    let earthQuake: EQEarthQuake
    
    init(with earthQuake: EQEarthQuake) {
        self.earthQuake = earthQuake
    }
    
    var urlString: String {
        return earthQuake.earthQuakeProperties.usgsUrl
    }
    
    var title: String {
        return earthQuake.earthQuakeProperties.title
    }
    
    var urlRequest: URLRequest? {
        guard !urlString.isEmpty else { return nil }
        guard let url = URL.init(string: urlString) else { return nil }
        return URLRequest.init(url: url)
    }
}
