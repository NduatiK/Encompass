//
//  AppRoutes.swift
//  Encompass_Example
//
//  Created by Nduati Kuria on 06/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Encompass


var AppRouter = Encompasser<Routes.AppRoutes>()


extension Routes {
    // Other types are usable but an enum is preferred since it has no sense of self
    // meaning no retension cycles
    enum AppRoutes: RouteConvertible {

        // currently the only flaw, case iteratable has to be implemented manaully if one wishes to pass values
        static var All: [Routes.AppRoutes] {
            return [.present,
                    .presentVC(value: ""),
                    .push,
                    .pushVC(value: "")]
        }

        case present

        // Path uniqueness is implemented by the enum ie no enum overloading (cant have to entries with the enum name present)
//       case present(value: String)

        case presentVC(value: String)


        case push

        case pushVC(value: String)


        var routeHandler: RouteHandler {
            switch self {
            case .present:
                return RouteHandler { (payload, currentController) in
                    let vc = ViewController2.instantiate()
                    currentController.present(vc, animated: true, completion: nil)
                }
            case .push:
                return RouteHandler { (payload, currentController) in
                    let vc = ViewController2.instantiate()
                    currentController.navigationController?.pushViewController(vc, animated: true)
                }
            case .presentVC:
                return RouteHandler { (payload, currentController) in
                    guard let string = payload["value"] as? String else { return }
                    let vc = ViewController2.instantiate()
                    vc.string = string
                    currentController.present(vc, animated: true, completion: nil)

                }
            case .pushVC:
                return RouteHandler { (payload, currentController) in
                    guard let string = payload["value"] as? String else { return }
                    let vc = ViewController2.instantiate()
                    vc.string = string
                    currentController.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
