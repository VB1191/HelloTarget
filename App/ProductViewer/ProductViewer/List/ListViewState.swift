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
	let description: String

	/// Gets font based on salePrice. if salePrice exists 2 price labels are shown - salePrice and original price
	func getFontForPriceLabel() -> UIFont {
		if let price = salePrice, !price.isEmpty {
			return UIFont.systemFont(ofSize: 16)
		} else {
			return UIFont.systemFont(ofSize: 26)
		}
	}

	/// Gets font String for originialPrice based on salePrice availability
	func getSalePriceLabelText() -> String {
		if let price = salePrice, !price.isEmpty {
			return price
		} else {
			return originalPrice
		}
	}

	/// Gets font color
	func getSalePriceLabelTextColor() -> UIColor {
		if let price = salePrice, !price.isEmpty {
			return .targetBullseyeRedColor
		} else {
			return .targetNeutralGrayColor
		}
	}

	/// gets the attributed string for ship label
	func getShipLabel() -> NSMutableAttributedString {
		/// assuming ship will be avialble based on some other condition
		let isShipAvaialble: Bool = true

		let attributedString = NSMutableAttributedString()
		attributedString.append(NSAttributedString(string:"ship", attributes:[NSAttributedString.Key.foregroundColor : UIColor.black]))
		attributedString.append(NSAttributedString(string:" or", attributes: [NSAttributedString.Key.foregroundColor:HarmonyColor.targetNeutralGrayColor]))

		return isShipAvaialble ? attributedString : NSMutableAttributedString(string: "")
	}
}


func ==(lhs: ListItemViewState, rhs: ListItemViewState) -> Bool {
    return lhs.title == rhs.title
        && lhs.salePrice == rhs.salePrice
		&& lhs.originalPrice == rhs.originalPrice
        && lhs.image == rhs.image
		&& lhs.aisle == rhs.aisle
}
