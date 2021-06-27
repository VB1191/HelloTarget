//
//  DetailViewState.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

/**
DetailViewState manages the view representation of ProductDetailView
*/
struct DetailViewState: TempoViewState {
	let title: String
	let imageURL: String?
	let salePrice: String?
	let originialPrics: String
	let description: String

	/// Gets font based on salePrice. if salePrice exists 2 price labels are shown - salePrice and original price
	func getFontForPriceLabel() -> UIFont {
		if let price = salePrice, !price.isEmpty {
			return UIFont.systemFont(ofSize: 18)
		} else {
			return UIFont.systemFont(ofSize: 26)
		}
	}

	/// Gets font String for originialPrice based on salePrice availability
	func getOriginalPriceLabelText() -> String {
		if let price = salePrice, !price.isEmpty {
			return "Was \(originialPrics)"
		} else {
			return originialPrics
		}
	}
}
