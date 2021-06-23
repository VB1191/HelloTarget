//
//  UINavigationControllerExtension.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 23/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UINavigationController {

	public func setTargetNavigationBar() {
		setNavigationBarBackgroundColor(color: UIColor.targetRed, tittleTextAttributesColor: UIColor.white, barStyle: .black)
	}

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