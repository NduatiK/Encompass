//
//  ErrorRouter.swift
//  Encompass_Example
//
//  Created by Nduati Kuria on 06/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Encompass

let ErrorRouter = Encompasser<Routes.ErrorRoute>()

extension Routes {
    enum ErrorRoute: RouteConvertible {
        static var All: [ErrorRoute] = [
            .error(error: ExampleErrors.Offline)
        ]
        
        case error(error: PrintableError)

        var routeHandler: RouteHandler {
            switch self {
            case .error:
                return RouteHandler({ (payload, currentController) in
                    guard let error = payload["error"] as? PrintableError else { return }

                    let alert = UIAlertController(title: error.title,
                                                  message: error.message,
                                                  preferredStyle: UIAlertControllerStyle.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    currentController.present(alert, animated: true, completion: nil)
                })
            }
        }
    }
}

protocol PrintableError {
    var title: String? { get }
    var message: String? { get }
}

enum ExampleErrors: Error, PrintableError {
    case Offline
    case LoggedOut

    var title: String? {
        switch self {
        case .Offline: return "Offline"
        case .LoggedOut: return "LoggedOut"
        }
    }

    var message: String? {
        return "Do something about it"
    }
}
