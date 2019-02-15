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
        registeredRouters.append(router.name)
        Navigator.routes.append(contentsOf: router.paths)
    }

    public static func navigate(to location: Location, from currentController: CurrentController) {
        if let router = registeredRoutes[location.path] {
            try! router.navigate(to: location, from: currentController)
            return
        }
    }
}

// MARK: URL Routing
extension Navigator {
    static func pathNameFrom(_ url: URL) -> Substring? {
        let deprefixedUrn = url.absoluteString
            .replacingOccurrences(of: Navigator.scheme, with: "")
        let urlSections = deprefixedUrn.split(separator: Character("?"))
        return urlSections.first
    }

    public static func navigate(registeredUrl url: URL) -> Bool {
        guard let pathNameSubString = pathNameFrom(url) else {
            return false
        }

        for routerName in registeredRouters {

            let routeName = routerName + String(pathNameSubString)
            if registeredRoutes[routeName] != nil {
                let internalRouteUrn = Navigator.scheme + routerName + url.absoluteString.replacingOccurrences(of: Navigator.scheme, with: "")
                let aUrl = URL(string: internalRouteUrn) ?? url

                if let location = Navigator.parse(url: aUrl)  {
                    Navigator.handle?(Location(path: routeName, payload: location.arguments))
                    return true
                }
            }
        }
        return false
    }
}
