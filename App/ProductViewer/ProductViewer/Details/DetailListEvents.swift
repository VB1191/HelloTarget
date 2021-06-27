//
//  DetailListEvents.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

struct DealAddToCartPressed: EventType {
	let productToAdd: DetailViewState
}

struct DealAddToListPressed: EventType {
	let productToAdd: DetailViewState
}
