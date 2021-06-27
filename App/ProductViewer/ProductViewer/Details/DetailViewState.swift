//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

struct DetailViewState: TempoViewState {
	let title: String
	let imageURL: String?
	let salePrice: String?
	let originialPrics: String
	let description: String

	func getFontForPriceLabel() -> UIFont {
		if let price = salePrice, !price.isEmpty {
			return UIFont.systemFont(ofSize: 18)
		} else {
			return UIFont.systemFont(ofSize: 26)
		}
	}

	func getOriginalPriceLabelText() -> String {
		if let price = salePrice, !price.isEmpty {
			return "Was \(originialPrics)"
		} else {
			return originialPrics
		}
	}
}
