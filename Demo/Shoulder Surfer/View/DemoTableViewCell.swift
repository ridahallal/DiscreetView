//
//  DemoTableViewCell.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 05/11/2022.
//

import UIKit
import DiscreetView

final class DemoTableViewCell: UITableViewCell {

    // MARK: - Properties

    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    private let amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.textAlignment = .center
        amountLabel.textColor = .systemPurple
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.font = .italicSystemFont(ofSize: UIFont.systemFontSize)

        return amountLabel
    }()

    private var discreetView: DiscreetView = {
        let containerView = DiscreetView()
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = Constants.ContainerViewCornerRadius

        return containerView
    }()

    // MARK: - Memory Management

    private static var allInstances = 0
    private let instance: Int

    // MARK: - Initialisation

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        DemoTableViewCell.allInstances += 1
        instance = DemoTableViewCell.allInstances

        // let initMessage = String(format: Constants.InitialisationMessage, instance)
        // print(initMessage)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) { return nil }

    deinit {
        // let deinitMessage = String(format: Constants.DeinitialisationMessage, instance)
        // print(deinitMessage)

        DemoTableViewCell.allInstances -= 1
    }

    // MARK: - Configuration

    func configure(with amount: String, _ position: CellPosition) {
        amountLabel.text = amount
        amountLabel.text = amount
        adjustPosition(position)
        discreetView.update()
    }
}

// MARK: - Namespaces

extension DemoTableViewCell {

    private enum Constants {

        static let InitialisationMessage = ">> DemoTableViewCell.init() #%d"
        static let DeinitialisationMessage = ">> DemoTableViewCell.deinit #%d"

        static let SmallPadding: CGFloat = 8
        static let MediumPadding: CGFloat = 16
        static let ContainerViewCornerRadius: CGFloat = 8

        static let Shown: CGFloat = 1
        static let Faded: CGFloat = 0.5
        static let SelectionAnimationDuration = 0.15
    }
}

// MARK: - Selection

extension DemoTableViewCell {

    // Empty Override
    override func setSelected(_ selected: Bool, animated: Bool) {}

    // Adjust alpha when user has their finger on or lifts their finger off the cell
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        adjustAlpha(highlighted)
    }

    // Animates the container view's alpha adjustment
    private func adjustAlpha(_ highlighted: Bool) {
        UIView.animate(withDuration: Constants.SelectionAnimationDuration) {
            self.discreetView.alpha = highlighted ? Constants.Faded : Constants.Shown
        }
    }
}

// MARK: - Helpers

extension DemoTableViewCell {

    private func setup() {
        backgroundColor = .clear
        layoutContainerView()
        layoutAmountLabel()
    }

    private func adjustPosition(_ position: CellPosition) {
        guard let topConstraint = topConstraint,
              let bottomConstraint = bottomConstraint else { return }

        switch position {
        case .First:
            topConstraint.constant = Constants.MediumPadding
            bottomConstraint.constant = -Constants.SmallPadding
        case .Sandwiched:
            topConstraint.constant = Constants.SmallPadding
            bottomConstraint.constant = -Constants.SmallPadding
        case .Last:
            topConstraint.constant = Constants.SmallPadding
            bottomConstraint.constant = -Constants.MediumPadding
        }
    }

    private func layoutContainerView() {
        addSubview(discreetView)

        topConstraint = discreetView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.SmallPadding)
        bottomConstraint = discreetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.SmallPadding)

        guard let topConstraint = topConstraint,
              let bottomConstraint = bottomConstraint else { return }

        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            discreetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.MediumPadding),
            discreetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.MediumPadding)
        ])
    }

    private func layoutAmountLabel() {
        discreetView.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: discreetView.topAnchor, constant: Constants.SmallPadding),
            amountLabel.bottomAnchor.constraint(equalTo: discreetView.bottomAnchor, constant: -Constants.SmallPadding),
            amountLabel.leadingAnchor.constraint(equalTo: discreetView.leadingAnchor, constant: Constants.SmallPadding),
            amountLabel.trailingAnchor.constraint(equalTo: discreetView.trailingAnchor, constant: -Constants.SmallPadding)
        ])
    }
}
