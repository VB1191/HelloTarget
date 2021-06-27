//
//  MockProductsList.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

class MockProductsList {

	lazy var jsonData = """
				{
				  "products": [
					{
					  "id": 0,
					  "title": "non mollit veniam ex",
					  "aisle": "b2",
					  "description": "minim ad et minim ipsum duis irure pariatur deserunt eu cillum anim ipsum velit tempor eu pariatur sunt mollit tempor ut tempor exercitation occaecat ad et veniam et excepteur velit esse eu et ut ipsum consectetur aliquip do quis voluptate cupidatat eu ut consequat adipisicing occaecat adipisicing proident laborum laboris deserunt in laborum est anim ad non",
					  "image_url": "https://picsum.photos/id/0/300/300",
					  "regular_price": {
						"amount_in_cents": 18406,
						"currency_symbol": "$",
						"display_string": "$184.06"
					  }
					},
					{
					  "id": 1,
					  "title": "sint aliqua mollit duis ullamco",
					  "aisle": "g33",
					  "description": "ad laboris do ad id ipsum dolore ad magna occaecat ea eu ex nisi culpa amet id officia labore ut tempor est dolor commodo aliqua ex nisi consectetur veniam ut aliquip amet esse exercitation voluptate aute id adipisicing nostrud quis non eu dolore ipsum ut officia pariatur anim amet id ex veniam sunt sit officia non excepteur cupidatat consequat incididunt ad culpa aliqua nisi magna voluptate esse excepteur id magna amet aute enim esse enim ex esse nostrud et sint nostrud irure ex aute nisi nisi nisi minim Lorem duis officia reprehenderit eiusmod ea magna tempor est",
					  "image_url": "https://picsum.photos/id/1/300/300",
					  "regular_price": {
						"amount_in_cents": 4025,
						"currency_symbol": "$",
						"display_string": "$40.25"
					  },
					  "sale_price": {
						"amount_in_cents": 734,
						"currency_symbol": "$",
						"display_string": "$7.34"
					  }
					}
				  ]
				}
				""".data(using: .utf8)!

	lazy var mockProducts: Products? = {
		let decoder = JSONDecoder()
		do {
				let products = try decoder.decode(Products.self, from: jsonData)
				return products

			} catch {
				return nil
		}
	}()
}

/* 2. Load from mock
let productsObject: Products? = MockProductsList().mockProducts

guard let productsArray: [Product] =  productsObject?.products else {
	return
}

var viewStateItems = [ListItemViewState]()
for product in productsArray {
	let viewStateItem = ListItemViewState(title: NSLocalizedString(product.title, comment: ""), price: product.regularPrice.displayString, image: UIImage(named: "\(1)"))
	viewStateItems.append(viewStateItem)
}

viewState.listItems = viewStateItems
*/

