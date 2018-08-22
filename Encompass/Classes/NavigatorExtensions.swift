//
//  RouteHandler.swift
//  Compass
//
//  Created by Nduati Kuria on 15/08/2018.
//

import Foundation
import Compass

fileprivate var registeredRoutes = [String: Routable]()
fileprivate var registeredRouters = [String]()


extension Navigator {
    public static func registerRouter<R: RouteConvertible>(_ router: Encompasser<R>) {
        for path in router.paths {
            registeredRoutes[path] = router.pathToRoutableMap[path]
        }
        registeredRouters.append(String(describing: router))
        Navigator.routes.append(contentsOf: router.paths)
    }

    public static func navigate(to location: Location, from currentController: CurrentController) {
        if let router = registeredRoutes[location.path] {
            try! router.navigate(to: location, from: currentController)
            return
        }
    }

    public static func navigate(registeredUrn: String) -> Bool {
        for routerName in registeredRouters {
            let urn = routerName + registeredUrn
            if registeredRoutes[urn] != nil {
                let location = Location(path: urn, payload: nil)
                Navigator.handle?(location)
                return true
            }
        }
        return false
    }

    public static func navigate(registeredUrl url: URL) -> Bool {
        return navigate(registeredUrn: url.absoluteString)
    }
}
