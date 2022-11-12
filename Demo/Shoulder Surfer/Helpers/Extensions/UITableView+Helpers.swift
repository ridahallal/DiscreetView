//
//  UITableView+Helpers.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 05/11/2022.
//

import UIKit

public extension UITableView {

    // MARK: - Namespaces

    private enum ErrorMessages {

        static let DqeueueCell = "Unable to Dequeue Reusable Table View Cell"
        static let DequeueHeaderFooter = "Unable to Dequeue Reusable Header Footer View"
    }

    // MARK: - Cells

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(ErrorMessages.DqeueueCell)
        }

        return cell
    }

    // MARK: - Headers/Footers

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError(ErrorMessages.DequeueHeaderFooter)
        }

        return headerFooterView
    }
}
