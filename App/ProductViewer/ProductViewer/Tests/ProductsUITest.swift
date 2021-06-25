//
//  ProductsUITest.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 25/06/21.
//  Copyright © 2021 Target. All rights reserved.
//


import XCTest
@testable import ProductViewer

class ProductsUITest: XCTestCase {

	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		XCUIApplication().launch()
	}

	func testProductListView() {
		let collectionView = XCUIApplication().collectionViews["productsListCollectionView"]

		// check collection view is loaded
		XCTAssert(collectionView.waitForExistence(timeout: 15), "Collection view not loaded")

		// assert that atleast one cell is loaded
		let allCells: XCUIElementQuery = collectionView.cells
		XCTAssert(allCells.count > 0, "No cells loaded for collection view")

		/// For first cell assert that title and price is not empty
		let firstCell: XCUIElement = allCells.element(boundBy: 0)
		let titleOfFirstCell = firstCell.staticTexts["productTitle"]
		XCTAssertFalse(titleOfFirstCell.label.isEmpty, "First cell's title is empty")

		/// Assert that atleast one price - sale/original is visible
		let originalPriceOfFirstCell = firstCell.staticTexts["originalSalePrice"]
		let salePriceOfFirstCell = firstCell.staticTexts["productSalePrice"]

		let atleastOnePriceAvailable = !originalPriceOfFirstCell.label.isEmpty || !salePriceOfFirstCell.label.isEmpty
		XCTAssert(atleastOnePriceAvailable, "First cell doesnt have sale price or original price text")
	}

}
