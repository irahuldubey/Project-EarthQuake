//
//  Constants.swift
//  EarthQuake
//
//  Created by Rahul Dubey on 3/9/21.
//

import Foundation

//MARK: - Segue Identifiers
struct SegueIdentifiers {
  static let detail = "DetailViewControllerSegue"
}

//MARK: - Reuse Identifiers
struct ReuseIdentifiers {
  static let eqCellIdentifier = "eqCellIdentifier"
}

// This can be get from a Messaging Service as well when the application loads so that we can change the text from the server as well. If we want to change if this is local I would move it to a localized strings file.
struct MesasgeStrings {
    static let connectionAlertMessage = "Your internet connection is offline"
    static let connectionAlertTitle = "Connection Error"
    static let webViewError = "Error"
    static let webViewTitle = "Failed to load"
}
