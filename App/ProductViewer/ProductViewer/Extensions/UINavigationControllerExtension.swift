//
//  UINavigationControllerExtension.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 23/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

/// Extenstion for serviceHelper
extension UINavigationController {

	/// Sets a default target themed navigation bar
	public func setTargetNavigationBar() {
		setNavigationBarBackgroundColor(color: .targetBullseyeRedColor, tittleTextAttributesColor: UIColor.white, barStyle: .default)
	}

	/// Sets custom navigation bar
	public func setNavigationBarBackgroundColor(color: UIColor?,
												tittleTextAttributesColor: UIColor,
												barStyle: UIBarStyle = .default) {
		navigationBar.barStyle = barStyle
		if #available(iOS 13.0, *) {
			let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			navBarAppearance.backgroundColor = color
			navBarAppearance.titleTextAttributes = [.foregroundColor: tittleTextAttributesColor]
			navigationBar.standardAppearance = navBarAppearance
			navigationBar.scrollEdgeAppearance = navBarAppearance
			navigationBar.compactAppearance = navBarAppearance
		} else {
			navigationBar.barTintColor = color
		}
	}
}
