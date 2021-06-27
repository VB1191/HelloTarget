//
//  ProductListComponent.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

struct ProductListComponent: Component {
    var dispatcher: Dispatcher?

    func prepareView(_ view: ProductListView, item: ListItemViewState) {
        // Called on first view or ProductListView
    }
    
    func configureView(_ view: ProductListView, item: ListItemViewState) {
		DispatchQueue.main.async {
			view.titleLabel.text = item.title
			view.salePriceLabel.text = item.salePrice
			view.originalPriceLabel.text = item.getOriginalPriceLabelText()
			view.productImage.image = item.image
			view.setPriceLabelFont(font: item.getFontForPriceLabel())
		}
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
    
    func selectView(_ view: ProductListView, item: ListItemViewState) {
		dispatcher?.triggerEvent(ListItemPressed(selectedViewState: item))
    }
}

extension ProductListComponent: HarmonyLayoutComponent {
    func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
        return 150.0
    }
}
