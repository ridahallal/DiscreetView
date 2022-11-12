//
//  ViewController.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 07/08/2022.
//

import UIKit

final class DemoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: DemoViewModel

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: DemoTableViewCell.reuseIdentifier)

        return tableView
    }()

    // MARK: - Memory Management

    private static var allInstances = 0
    private let instance: Int

    // MARK: - Initialisation

    init(viewModel: DemoViewModel) {
        DemoViewController.allInstances += 1
        instance = DemoViewController.allInstances

        // let initMessage = String(format: Constants.InitialisationMessage, instance)
        // print(initMessage)

        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.title
    }

    required init?(coder: NSCoder) { return nil }

    deinit {
        // let deinitMessage = String(format: Constants.DeinitialisationMessage, instance)
        // print(deinitMessage)

        DemoViewController.allInstances -= 1
    }

    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        layoutTableView()
    }
}

// MARK: - Namespaces

extension DemoViewController {

    private enum Constants {

        static let InitialisationMessage = ">> DemoViewController.init() #%d"
        static let DeinitialisationMessage = ">> DemoViewController.deinit #%d"

        static let CellHeightRatio = 0.125
    }
}

// MARK: - UITableViewDelegate

extension DemoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension DemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let demoCell: DemoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let transaction = viewModel.transaction(at: indexPath)
        let position = viewModel.position(at: indexPath)
        demoCell.configure(with: transaction, position)

        return demoCell
    }
}

// MARK: - Helpers

extension DemoViewController {

    private func setupView() {
        view.backgroundColor = .systemGroupedBackground
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func layoutTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
