//
//  ListViewState.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// List view state
struct ListViewState: TempoViewState, TempoSectionedViewState {
    var listItems: [TempoViewStateItem]
    
    var sections: [TempoViewStateItem] {
        return listItems
    }
}

/// View state for each list item.
struct ListItemViewState: TempoViewStateItem, Equatable {
    let title: String
    let salePrice: String?
	var originalPrice: String
    let image: UIImage?
	let aisle: String
	let imageURL: String?

	func getFontForPriceLabel() -> UIFont {
		if let price = salePrice, !price.isEmpty {
			return UIFont.systemFont(ofSize: 16)
		} else {
			return UIFont.systemFont(ofSize: 26)
		}
	}

	func getOriginalPriceLabelText() -> String {
		if let price = salePrice, !price.isEmpty {
			return "Was \(originalPrice)"
		} else {
			return originalPrice
		}
	}
}


func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.title == rhs.title
        && lhs.salePrice == rhs.salePrice
		&& lhs.originalPrice == rhs.originalPrice
        && lhs.image == rhs.image
		&& lhs.aisle == rhs.aisle
}
