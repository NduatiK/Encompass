//
//  ViewController.swift
//  Encompass
//
//  Created by NduatiK on 08/15/2018.
//  Copyright (c) 2018 NduatiK. All rights reserved.
//

import UIKit
import Reusable

class ViewController: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func push(_ sender: Any) {
        AppRouter.navigate(to: .push)

    }
    @IBAction func pushWithString(_ sender: Any) {
        let text = textField.text ?? ""
        AppRouter.navigate(to: .pushVC(value: text))
    }
    @IBAction func present(_ sender: Any) {
        AppRouter.navigate(to: .present)

    }
    @IBAction func presentWithString(_ sender: Any) {
        let text = textField.text ?? ""
        AppRouter.navigate(to: .presentVC(value: text, val: "tokyo"))
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
