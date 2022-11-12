//
//  DiscreetView.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 24/08/2022.
//

import UIKit

public class DiscreetView: UIView {

    // MARK: - Static Properties

    // Keeps track of whether Discreet mode is on/off
    private static var isDiscreet = false

    // Generate haptic feedback once the user waves their hand on top of the ambient light sensor
    private static var hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Properties

    // The view that is overlaid on top of a DiscreetView instance
    private var blurView: VisualEffectView?

    // Keeps track of the timestamps at which the wave gesture began/ended
    private var startTime: Date?
    private var endTime: Date?

    // MARK: - Memory Management

    private static var allInstances = 0
    private let instance: Int

    // MARK: - Initialisation

    override init(frame: CGRect) {
        DiscreetView.allInstances += 1
        instance = DiscreetView.allInstances

        // let initMessage = String(format: Constants.InitialisationMessage, instance)
        // print(initMessage)

        super.init(frame: frame)
        listenToProximityChanges()
    }

    required init?(coder: NSCoder) { return nil }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIDevice.proximityStateDidChangeNotification,
            object: UIDevice.current)

        // let deinitMessage = String(format: Constants.DeinitialisationMessage, instance)
        // print(deinitMessage)

        DiscreetView.allInstances -= 1
    }

    // MARK: - API

    public func update() {
        if DiscreetView.isDiscreet {
            removeBlurView()
            addBlurView()
        } else {
            removeBlurView()
        }
    }
}


// MARK: - Namespaces

private extension DiscreetView {

    enum Constants {

        static let InitialisationMessage = ">> DiscreetView.init() #%d"
        static let DeinitialisationMessage = ">> DiscreetView.deinit #%d"

        static let WaveGestureDuration = 1

        static let BlurViewIntensity = 0.15
        static let BlurViewPadding: CGFloat = 8
        static let BlurViewCornerRadius: CGFloat = 8
    }
}

// MARK: - Helpers

private extension DiscreetView {

    // Called by the property wrapper
    func listenToProximityChanges() {
        UIDevice.current.isProximityMonitoringEnabled = true

        if UIDevice.current.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(proximityDidChange),
                name: UIDevice.proximityStateDidChangeNotification,
                object: UIDevice.current)
        }
    }

    // Adds a blurred view on top of a DiscreetView instance
    func addBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurView = VisualEffectView(visualEffect: blurEffect, intensity: Constants.BlurViewIntensity)

        guard let blurView = blurView else { return }

        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = layer.cornerRadius
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)

        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // Removes the blurred view from a DiscreetView instance
    private func removeBlurView() {
        blurView?.removeFromSuperview()
        blurView = nil
    }

    // UIDevice.proximityStateDidChangeNotification selector
    @objc func proximityDidChange(notification: NSNotification) {
        guard let device = notification.object as? UIDevice else { return }

        if device.proximityState {
            startTime = Date()
            endTime = nil
        } else {
            endTime = Date()
        }

        guard let startTime = startTime,
              let endTime = endTime else { return }
        let elapsed = endTime.timeIntervalSince(startTime)
        let duration = Int(elapsed)

        guard duration < Constants.WaveGestureDuration else { return }

        if blurView == nil {
            addBlurView()
        } else {
            removeBlurView()
        }

        generateHapticFeedbackIfNeeded()
    }

    // Generates haptic feedback when the wave gesture begins/ends
    private func generateHapticFeedbackIfNeeded() {
        let oldValue = DiscreetView.isDiscreet
        DiscreetView.isDiscreet = (blurView != nil)

        if oldValue != DiscreetView.isDiscreet {
            DiscreetView.hapticFeedbackGenerator.impactOccurred()
        }
    }
}
