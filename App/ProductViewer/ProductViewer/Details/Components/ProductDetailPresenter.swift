//
//  ProductDetailComponent.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

class ProductDetailPresenter: TempoPresenter {

	var dispatcher: Dispatcher?
	var productDetailVC: DetailViewController
	var currentViewState: DetailViewState?

	init(detailVC: DetailViewController, dispatcher: Dispatcher) {
		self.productDetailVC = detailVC
		self.dispatcher = dispatcher
	}

	func present(_ viewState: DetailViewState) {
		let detailView: ProductDetailView = self.productDetailVC.productDetailView
		configureView(detailView, viewState: viewState)
	}

	/// Not protocol method: keeping parity with Component
	func configureView(_ detailView: ProductDetailView, viewState: DetailViewState) {

		currentViewState = viewState

		detailView.titleLabel.text = viewState.title
		detailView.salePriceLabel.text = viewState.salePrice
		detailView.originalPriceLabel.text = viewState.getOriginalPriceLabelText()
		detailView.descriptionLabel.text = viewState.description
		detailView.setPriceLabelFont(font: viewState.getFontForPriceLabel())

		/// add targets
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

	@objc func addToCartButtonClicked() {
		guard let viewState = currentViewState else {
			return
		}
		dispatcher?.triggerEvent(DealAddToCartPressed(productToAdd: viewState))
	}

	@objc func addToListButtonClicked() {
		guard let viewState = currentViewState else {
			return
		}
		dispatcher?.triggerEvent(DealAddToListPressed(productToAdd: viewState))
	}
}
