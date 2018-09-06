//
//  RouteConvertible.swift
//  Encompass
//
//  Created by Nduati Kuria on 15/08/2018.
//

import Foundation
import Compass

public protocol RouteConvertible {
    static var All: [Self] { get }
    var routeHandler: RouteHandler { get }
}

extension RouteConvertible {
    public static var associatedPaths: [String] {
        return All.map { $0.route.path }
    }

    var caseName: String {
        return Mirror(reflecting: self).children.first?.label ?? String(describing: self)
    }

    var route: Route {
        return self.routeBuilder()
    }

    // Creates a route that automatically injects the enum name as the route name
    func routeBuilder() -> Route {

        var payload = [String: Any]()

        if let enumLabel = Mirror.init(reflecting: self).children.first {
            let associatedValues = Mirror.init(reflecting: enumLabel.value)
            associatedValues.children.forEach({ associatedValue in
                if let label = associatedValue.label {
                    payload[label] =  associatedValue.value
                }
            })
        }

        return Route(path: self.caseName, payload: payload)
    }
}
