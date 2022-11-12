//
//  DemoViewModel.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 05/11/2022.
//

import Foundation

struct DemoViewModel {

    // MARK: - Data Source

    private let transactions = [
        "$50",
        "$70",
        "$90"
    ]

    // MARK: - API

    var title: String {
        return "Transactions"
    }

    var numberOfRows: Int {
        return transactions.count
    }

    func transaction(at indexPath: IndexPath) -> String {
        return transactions[indexPath.row]
    }

    func position(at indexPath: IndexPath) -> CellPosition {
        switch indexPath.row {
        case 0:
            return .First
        case transactions.count - 1:
            return .Last
        default:
            return .Sandwiched
        }
    }
}
