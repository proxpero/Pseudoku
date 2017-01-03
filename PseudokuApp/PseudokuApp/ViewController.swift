//
//  ViewController.swift
//  PseudokuApp
//
//  Created by Todd Olsen on 12/21/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let stack = stackView(with: .vertical)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stack)
//        view.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
//        view.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
//        stack.heightAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
//
//        stack.backgroundColor = .green
    }

    func stackView(with axis: UILayoutConstraintAxis) -> UIStackView {
        let stackView = UIStackView(frame: view.frame)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = axis
        return stackView
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraBegin(_ sender: UIButton) {
        
    }

}

