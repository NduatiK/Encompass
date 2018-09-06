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
    let callback: RouteHandlerCallback
    public init(_ routeHandlerCallback: @escaping RouteHandlerCallback) {
        self.callback = routeHandlerCallback
    }

    public func navigate(to location: Location, from currentController: CurrentController) throws {
        self.callback(location.payload as? [String: Any] ?? [String: Any](), currentController)
    }
}
