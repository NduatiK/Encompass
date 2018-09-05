//
//  Router.swift
//
//  Created by Nduati Kuria on 08/08/2018.
//  Copyright © 2018 nduatiKuria. All rights reserved.
//

import UIKit
import Compass

public final class Encompasser<R: RouteConvertible> {
    var _pathToRoutableMap = [String: Routable]()

     private(set) var pathToRoutableMap: [String: Routable] {
        get {
            return _pathToRoutableMap
        } set {
            _pathToRoutableMap = newValue
        }
    }

    var paths: [String] {
        return Array(pathToRoutableMap.keys)
    }

    public init() {
        pathToRoutableMap = R.All.reduce(into: [String: Routable](), { (map, routeConvertible) in
            let uniquePath = String(describing: self) + routeConvertible.route.path
            map[uniquePath] = routeConvertible.routeHandler
        })
    }

    public func navigate(to routeConvertible: R) {
        let route = routeConvertible.route
        try! Navigator.navigate(location: Location(path: String(describing: self) + route.path,
                                                   payload: route.payload))
    }
}
