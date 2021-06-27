//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/**
ProductListComponent that configures ProductListView with given ListItemViewState and handles view events
*/
struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }

	/// configues given ProductListView with ListItemViewState
    func configureView(_ view: ProductListView, item: ListItemViewState) {

		view.titleLabel.text = item.title
		view.salePriceLabel.text = item.getSalePriceLabelText()
		view.salePriceLabel.textColor = item.getSalePriceLabelTextColor()
		view.productImage.image = item.image
		view.shipLabel.attributedText = item.getShipLabel()
		view.asileLabel.text = item.aisle

		if let imageURLFound = item.imageURL {
			ImageLoaderHelper.loadImageUsingCache(withUrl: imageURLFound) { loadedImage in
				if let imageFound = loadedImage {
					DispatchQueue.main.async {
						view.productImage.image = imageFound
					}
				}
			}
		}
    }

	/// dispatches event
    func selectView(_ view: ProductListView, item: ListItemViewState) {
		dispatcher?.triggerEvent(ListItemPressed(selectedViewState: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
	/// custom height
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
}
