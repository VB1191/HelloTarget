//
//  ProductDetailComponent.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

/**
ProductDetailPresenter configures (presents) a new viewState to ProductDetailView that it recieves
*/
class ProductDetailPresenter: TempoPresenter {

	// MARK: Properties

	/// Dispatcher to dispatch new events from the view
	var dispatcher: Dispatcher?
	/// View controller whose view will be given the new view state
	var productDetailVC: DetailViewController
	/// Current view state to keep track of what is selected at class level
	var currentViewState: DetailViewState?

	// MARK: Initializer
	init(detailVC: DetailViewController, dispatcher: Dispatcher) {
		self.productDetailVC = detailVC
		self.dispatcher = dispatcher
	}

	// MARK: Setup
	func present(_ viewState: DetailViewState) {
		let detailView: ProductDetailView = self.productDetailVC.productDetailView
		configureView(detailView, viewState: viewState)
	}

	/// Configures the detailView with new view state
	func configureView(_ detailView: ProductDetailView, viewState: DetailViewState) {

		currentViewState = viewState

		detailView.titleLabel.text = viewState.title
		detailView.salePriceLabel.text = viewState.salePrice
		detailView.originalPriceLabel.text = viewState.getOriginalPriceLabelText()
		detailView.descriptionLabel.text = viewState.description
		detailView.setPriceLabelFont(font: viewState.getFontForPriceLabel())

		/// add targets for 2 buttons so that dispatcher can dispatch an event when these are inetracted with
		detailView.addToCartButton.addTarget(self, action: #selector(addToCartButtonClicked) , for: .touchUpInside)

		detailView.addToListButton.addTarget(self, action: #selector(addToListButtonClicked) , for: .touchUpInside)

		if let imageURLFound = viewState.imageURL {
			ImageLoaderHelper.loadImageUsingCache(withUrl: imageURLFound) { loadedImage in
				if let imageFound = loadedImage {
					DispatchQueue.main.async {
						detailView.productImageView.image = imageFound
					}
				}
			}
		}
	}

	/// dispatcher sends a new event stating add to cart was clicked. Observer will handle the implementation
	@objc func addToCartButtonClicked() {
		guard let viewState = currentViewState else {
			return
		}
		dispatcher?.triggerEvent(DealAddToCartPressed(productToAdd: viewState))
	}

	/// dispatcher sends a new event stating add to cart was clicked. Observer will handle the implementation
	@objc func addToListButtonClicked() {
		guard let viewState = currentViewState else {
			return
		}
		dispatcher?.triggerEvent(DealAddToListPressed(productToAdd: viewState))
	}

	/// dispatches share event
	func shareButtonClicked() {
		guard let viewState = currentViewState else {
			return
		}
		dispatcher?.triggerEvent(DealShare(productToShare: viewState))
	}
}
