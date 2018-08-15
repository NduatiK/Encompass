//
//  RouteHandler.swift
//  Compass
//
//  Created by Nduati Kuria on 15/08/2018.
//

import Foundation
import Compass

public typealias RouteHandlerCallback = ((_ payload: [String: Any], _ currentController: CurrentController) -> Void)

public struct RouteHandler: Routable {
    let routeHandler: RouteHandlerCallback
    public init(withRouteHandler routeHandler: @escaping RouteHandlerCallback) {
        self.routeHandler = routeHandler
    }

    public func navigate(to location: Location, from currentController: CurrentController) throws {
        self.routeHandler(location.payload as? [String: Any] ?? [String: Any](), currentController)
    }

}
