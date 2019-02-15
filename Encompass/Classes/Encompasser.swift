//
//  Router.swift
//
//  Created by Nduati Kuria on 08/08/2018.
//  Copyright © 2018 nduatiKuria. All rights reserved.
//

import UIKit
import Compass

public final class Encompasser<R: RouteConvertible> {
    private(set) var pathToRoutableMap = [String: Routable]()

    var name: String {
        return String(describing: self).replacingOccurrences(of: "<", with: ".").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: ".", with: "")
    }

    var paths: [String] {
        return Array(pathToRoutableMap.keys)
    }

    public func canRoute(_ location: Location) -> Bool {
        return paths.contains(location.path)
    }

    public init() {
        pathToRoutableMap = R.All.reduce(into: [String: Routable](), { (map, routeConvertible) in
            let uniquePath = name + routeConvertible.route.path
            map[uniquePath] = routeConvertible.routeHandler
        })
    }

    public func navigate(to routeConvertible: R) {
        let route = routeConvertible.route
        try! Navigator.navigate(location: Location(path: name + route.path,
                                                   payload: route.payload))
    }
}
