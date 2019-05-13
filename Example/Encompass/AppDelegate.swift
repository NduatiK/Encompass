//
//  AppDelegate.swift
//  Encompass
//
//  Created by NduatiK on 08/15/2018.
//  Copyright (c) 2018 NduatiK. All rights reserved.
//

import UIKit
import Compass

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupEncompass()
        return true
    }

    func setupEncompass() {
         Navigator.scheme = "encompass" // should match deep link url scheme if you want to support deep linking

        /*
         Test out deeplinking by adding the following links to the notes app and tapping the links

         encompass://present
         encompass://presentVC?value=3

        */

        // Register routes you'd like to support
        Navigator.registerRouter(AppRouter)
        Navigator.registerRouter(ErrorRouter)
        Navigator.handle = { [weak self] location in
            /* Handle all errors */
            if ErrorRouter.canRoute(location) {
                // Navigator.navigate(to: location, from: loginVC)
            }

            /* Do safety checks here */

//             guard loggedIn else { ErrorRouter.navigate(to: ExampleErrors.LoggedOut);  return }

//             guard let self = self else { return }



            // Choose the current visible controller

            // NEVER DO THIS -> BE SAFE
            let currentController = (self!.window!.rootViewController as! UINavigationController).viewControllers.first!

            // Navigate
            Navigator.navigate(to: location, from: currentController)
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return Navigator.navigate(registeredUrl: url)
    }
}

