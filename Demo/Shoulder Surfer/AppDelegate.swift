//
//  AppDelegate.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 07/08/2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Memory Management

    private static var allInstances = 0
    private let instance: Int

    // MARK: - Initialisation

    override init() {
        AppDelegate.allInstances += 1
        instance = AppDelegate.allInstances

        let initMessage = String(format: Constants.InitialisationMessage, instance)
        print(initMessage)

        super.init()
    }

    deinit {
        let deinitMessage = String(format: Constants.DeinitialisationMessage, instance)
        print(deinitMessage)

        AppDelegate.allInstances -= 1
    }

    // MARK: - Application Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()

        return true
    }

    private func setRootViewController() {
        window = UIWindow()

        guard let window = window else { return }

        let viewModel = DemoViewModel()
        let demoViewController = DemoViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: demoViewController)
        navigationController.navigationBar.prefersLargeTitles = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

// MARK: - Namespaces

private extension AppDelegate {

    enum Constants {

        static let InitialisationMessage = ">> AppDelegate.init() #%d"
        static let DeinitialisationMessage = ">> AppDelegate.deinit #%d"
    }
}
