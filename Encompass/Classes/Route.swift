//
//  Route.swift
//  Compass
//
//  Created by Nduati Kuria on 15/08/2018.
//

import Foundation
import Compass

public final class Route {
    public let path: String
    public let payload: Any?
    public init(path: String,
                payload: Any? = nil) {
        self.path = path
        self.payload = payload
    }
}
