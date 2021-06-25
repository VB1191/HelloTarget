//
//  Product.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

/**
Model that represents a product
*/
struct Product: Codable {
	let productId: Int
	let title: String
	let description: String
	let aisle: String
	let regularPrice: Price
	let salePrice: Price?
	let imageUrl: String?

	enum CodingKeys: String, CodingKey {
		case productId = "id"
		case title
		case description
		case aisle
		case regularPrice = "regular_price"
		case salePrice = "sale_price"
		case imageUrl = "image_url"
	}
}
