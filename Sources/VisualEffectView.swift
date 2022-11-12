//
//  VisualEffectView.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 05/11/2022.
//

import UIKit

/// UIVisualEffectView with variable intensity

// MARK: - Visual Effect View

final class VisualEffectView: UIVisualEffectView {

    // MARK: - Properties

    private let intensity: CGFloat
    private let visualEffect: UIVisualEffect
    private var animator: UIViewPropertyAnimator?

    // MARK: - Memory Management

    private static var allInstances = 0
    private let instance: Int

    // MARK: - Initialisation

    init(visualEffect: UIVisualEffect, intensity: CGFloat) {
        VisualEffectView.allInstances += 1
        instance = VisualEffectView.allInstances

        let initMessage = String(format: Constants.InitialisationMessage, instance)
        print(initMessage)

        self.intensity = intensity
        self.visualEffect = visualEffect

        super.init(effect: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    deinit {
        animator?.stopAnimation(true)

        let deinitMessage = String(format: Constants.DeinitialisationMessage, instance)
        print(deinitMessage)

        VisualEffectView.allInstances -= 1
    }

    // MARK: - Layout

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = visualEffect
        }
        animator?.fractionComplete = intensity
    }
}

// MARK: - Namespaces

private extension VisualEffectView {

    enum Constants {

        static let InitialisationMessage = ">> VisualEffectView.init() #%d"
        static let DeinitialisationMessage = ">> VisualEffectView.deinit #%d"
    }
}
