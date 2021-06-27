//
//  DetailCoordinator.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product detail
 */
class DetailCoordinator: TempoCoordinator {

	// MARK: Presenters, view controllers, view state.

	var presenters = [TempoPresenterType]() {
		didSet {
			updateUI()
		}
	}

	fileprivate var viewState: DetailViewState {
		didSet {
			updateUI()
		}
	}


	fileprivate func updateUI() {
		for presenter in presenters {
			presenter.present(viewState)
		}
	}

	let dispatcher = Dispatcher()

	lazy var viewController: DetailViewController = {
		return DetailViewController.viewControllerFor(coordinator: self)
	}()

	// MARK: Init

	required init(previousViewState: ListItemViewState) {
		/// check this. basically need to init from what was selected from list
		viewState = DetailViewState(title: previousViewState.title, imageURL: previousViewState.imageURL, salePrice: previousViewState.salePrice, originialPrics: previousViewState.originalPrice, description: previousViewState.description)
		updateState()
		registerListeners()
	}

	// MARK: ListCoordinator

	fileprivate func registerListeners() {
		dispatcher.addObserver(DealAddToListPressed.self) { [weak self] viewState in
			let alert = UIAlertController(title: "\(viewState.productToAdd.title)", message: "added to list", preferredStyle: .alert)
			alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
			self?.viewController.present(alert, animated: true, completion: nil)
		}

		dispatcher.addObserver(DealAddToCartPressed.self) { [weak self] viewState in
			let alert = UIAlertController(title: "\(viewState.productToAdd.title)", message: "added to cart", preferredStyle: .alert)
			alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
			self?.viewController.present(alert, animated: true, completion: nil)
		}
	}

	func updateState() {
	}
}
