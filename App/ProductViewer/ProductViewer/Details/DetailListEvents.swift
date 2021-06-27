//
//  DetailListEvents.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

/// Event dispatched when add to cart button is clicked
struct DealAddToCartPressed: EventType {
	/// viewState of product to be added
	let productToAdd: DetailViewState
}

/// Event dispatched when add to list button is clicked
struct DealAddToListPressed: EventType {
	/// viewState of product to be added
	let productToAdd: DetailViewState
}

/// Event dispatched when share button is clicked
struct DealShare: EventType {
	// product to be shared
	let productToShare: DetailViewState
}
