//
//  Price.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

/**
Model that represents Price of a product
*/
struct Price: Codable {
	let amountInCents: Int
	let currencySymbol: String
	let displayString: String

	enum CodingKeys: String, CodingKey {
		case amountInCents = "amount_in_cents"
		case currencySymbol = "currency_symbol"
		case displayString = "display_string"
	}
}
