//
//  ReusableView.swift
//  Shoulder Surfer
//
//  Created by Rida Hallal on 05/11/2022.
//

// Anything that conforms to ReusableView gets a reuseIdentifier for free

public protocol ReusableView {

    static var reuseIdentifier: String { get }
}

// Default Implementation

public extension ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
