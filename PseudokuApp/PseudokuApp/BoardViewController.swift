//
//  BoardViewController.swift
//  PseudokuApp
//
//  Created by Todd Olsen on 12/21/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit
import Engine

final class BoardViewController: UIViewController {

    @IBOutlet var buttons: [SquareButton]!

    var columns: [SquareButton] = []
    var rows: [SquareButton] = []
    var boxes: [SquareButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var tag = 0
        for button in buttons {
            button.backgroundColor = .white
            button.tag = tag
            button.addTarget(self, action: #selector(squarePress(for:)), for: .touchUpInside)
            button.setTitle("", for: .normal)
            tag += 1
        }

    }

    func button(for number: Int) -> SquareButton {
        return buttons[number]
    }

    func button(at location: Location) -> SquareButton {
        return button(for: location.rawValue)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard touches.count == 1, let touch = touches.first else { return }
//        print(touch.location(in: view))
//    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        print(touch.location(in: view))
    }

    func showNumberPad(for location: Location) {

        let blur = blurredView
        view.addSubview(blur)

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NumberPadViewController") as? NumberPadViewController else { fatalError("Could not create `NumberPadViewController`") }

        vc.completion = { number in

            let selection = self.button(at: location)
            let title = number == nil ? "" : "\(number!)"

            selection.setTitle(title, for: .normal)

            UIView.animate(withDuration: 0.2, animations: { vc.view.alpha = 0.0 }, completion: { _ in
                vc.view.removeFromSuperview()
                blur.removeFromSuperview()
            })
        }

        addChildViewController(vc)
        vc.view.backgroundColor = .lightGray
        vc.view.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
        vc.view.center = view.center

        view.addSubview(vc.view)

    }

    func didSelectNumber(_ number: Int, with numberpadViewController: NumberPadViewController) {
    }
    
    func highlightPeers(of square: Location) {

        let peers = buttons.filter { square.peers.contains(Location(rawValue: $0.tag)!) }
        for peer in peers {
            peer.backgroundColor = .blue
        }

    }

    func squareTouch(for button: SquareButton) {
        print(Location(rawValue: button.tag)!)
    }

    func squarePress(for button: SquareButton) {

        let location = Location(rawValue: button.tag)!
//        highlightPeers(of: location)
        showNumberPad(for: location)

    }

}

final class SquareButton: UIButton {

//    var selectionHandler: (Int) -> Void = { _ in }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        next?.touchesMoved(touches, with: event)
//        guard let touch = touches.first else { return }
//        print("** \(touch.location(in: self))")
    }
}

import CoreImage

extension UIViewController {

    var blurredView: UIView {

        let effect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = view.frame

        return effectView

    }


}


