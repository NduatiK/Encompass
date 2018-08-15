//
//  Router.swift
//
//  Created by Nduati Kuria on 08/08/2018.
//  Copyright © 2018 nduatiKuria. All rights reserved.
//

import UIKit
import Compass

public final class THRouter<R: RouteConvertible>: Routable {
    let pathToRoutableMap: [String: Routable]

    var paths: [String] {
        return Array(pathToRoutableMap.keys)
    }

    public init() {
        pathToRoutableMap = R.All.reduce(into: [String: Routable](), { (map, routeConvertible) in
            map[routeConvertible.route.path] = routeConvertible.routeHandler
        })
    }

    public func navigate(to location: Location, from currentController: CurrentController) {

        if let router = pathToRoutableMap[location.path] {
            try! router.navigate(to: location, from: currentController)
            return
        }
    }

    public func navigate(to routeConvertible: R) {
        let route = routeConvertible.route
        try! Navigator.navigate(location: Location(path: route.path,
                                                   payload: route.payload))
    }
}

extension Navigator {
    public static func registerRouter<R: RouteConvertible>(_ router: THRouter<R>) {
        Navigator.routes.append(contentsOf: router.paths)
    }
}

