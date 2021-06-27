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

		/// Now validate detail page
		firstCell.tap()
		
		let productdetailcontainerstack = XCUIApplication()/*@START_MENU_TOKEN@*/.otherElements["productDetailContainerStack"]/*[[".scrollViews[\"productDetailScroll\"].otherElements[\"productDetailContainerStack\"]",".otherElements[\"productDetailContainerStack\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		XCTAssert(productdetailcontainerstack.waitForExistence(timeout: 15), "Detail page stack view not loaded")

		let titleElement = productdetailcontainerstack/*@START_MENU_TOKEN@*/.staticTexts["productDetailTitle"]/*[[".staticTexts[\"non mollit veniam ex\"]",".staticTexts[\"productDetailTitle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		/// Assert that title is not empty
		XCTAssert(!titleElement.label.isEmpty, "Product detail title text found empty")


		/// Assert description is not empty
		let descriptionElement = productdetailcontainerstack/*@START_MENU_TOKEN@*/.staticTexts["productDetailDescription"]/*[[".staticTexts[\"minim ad et minim ipsum duis irure pariatur deserunt eu cillum anim ipsum velit tempor eu pariatur sunt mollit tempor ut tempor exercitation occaecat ad et veniam et excepteur velit esse eu et ut ipsum consectetur aliquip do quis voluptate cupidatat eu ut consequat adipisicing occaecat adipisicing proident laborum laboris deserunt in laborum est anim ad non\"]",".staticTexts[\"productDetailDescription\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		XCTAssert(!descriptionElement.label.isEmpty, "Product detail description text found empty")

		// Assert cart button is enabled and tap
		let cartButtonElement = productdetailcontainerstack.staticTexts["Add to cart"]
		XCTAssert(cartButtonElement.isEnabled, "Cart button is not enabled")
		cartButtonElement.tap()

		// Assert being able to go through alert
		let alertElement = XCUIApplication().alerts[titleElement.label]
		let okCartButton = alertElement.scrollViews.otherElements.buttons["OK"]
		okCartButton.tap()

		// Assert list button is enabled and tap
		let listButtonElement = productdetailcontainerstack.staticTexts["Add to list"]
		XCTAssert(listButtonElement.isEnabled, "List button is not enabled")
		listButtonElement.tap()
		XCTAssert(alertElement.exists, "Alert not found after clicking add to list button")
		okCartButton.tap()
		
	}

}
