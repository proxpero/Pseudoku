//
//  NumberPadViewController.swift
//  PseudokuApp
//
//  Created by Todd Olsen on 1/2/17.
//  Copyright © 2017 Todd Olsen. All rights reserved.
//

import UIKit

final class NumberPadViewController: UIViewController {

    var completion: (Int?) -> Void = { _ in }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let result: Int? = sender.tag == 0 ? nil : sender.tag
        completion(result)
    }
    
}
