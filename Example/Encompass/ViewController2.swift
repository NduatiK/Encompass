//
//  ViewController.swift
//  Encompass
//
//  Created by NduatiK on 08/15/2018.
//  Copyright (c) 2018 NduatiK. All rights reserved.
//

import UIKit
import Reusable

class ViewController2: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    var passedValue: String?
    @IBOutlet weak var valueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let string = passedValue {
            valueLabel.text = "Passed in \"\(string)\""
        }
    }
    @IBAction func dismissTouched(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

