//
//  ListEvents.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Tempo

/// Event dispatched when item in products list is selected
struct ListItemPressed: EventType {
	/// view state of the selected product
	let selectedViewState: ListItemViewState
}
