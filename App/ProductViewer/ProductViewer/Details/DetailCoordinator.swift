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

	// MARK: Presenters, view controllers, view state, Dispatcher

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

	let dispatcher = Dispatcher()

	lazy var viewController: DetailViewController = {
		return DetailViewController.viewControllerFor(coordinator: self)
	}()

	// MARK: Init

	required init(previousViewState: ListItemViewState) {
		/// check this. basically need to init from what was selected from list
		viewState = DetailViewState(title: previousViewState.title, imageURL: previousViewState.imageURL, salePrice: previousViewState.salePrice, originialPrics: previousViewState.originalPrice, description: previousViewState.description)
		registerListeners()
	}

	// MARK: ListCoordinator

	fileprivate func registerListeners() {
		// Temporary handling of button clicks
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

		dispatcher.addObserver(DealShare.self) { [weak self] viewState in
			self?.handleShare(viewState.productToShare)
		}
	}

	fileprivate func updateUI() {
		for presenter in presenters {
			presenter.present(viewState)
		}
	}

	/// Shares the given product's title, price, target website url and target logo
	func handleShare(_ viewStateToShare: DetailViewState) {
		// Setting description
		var firstActivityItem = "Check out this amazing Target deal!!"

		// Setting url
		var price: String
		if let salePrice = viewStateToShare.salePrice, !salePrice.isEmpty {
			price = salePrice
		} else {
			price = viewStateToShare.originialPrics
		}
		firstActivityItem += "\(viewStateToShare.title) is priced at ONLY \(price)"

		/// Ideally we could use a smart link here, but for now share will just show generic target website
		let secondActivityItem = URL(string:"http://target.com/")!

		let thirdActivityItem = UIImage(named: "target")!

		let activityViewController : UIActivityViewController = UIActivityViewController(
			activityItems: [firstActivityItem, secondActivityItem, thirdActivityItem], applicationActivities: nil)

		// for iPad
		activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
		activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

		if #available(iOS 13.0, *) {
			activityViewController.isModalInPresentation = true
		}

		activityViewController.excludedActivityTypes = [
			UIActivity.ActivityType.postToWeibo,
			UIActivity.ActivityType.print,
			UIActivity.ActivityType.assignToContact,
			UIActivity.ActivityType.saveToCameraRoll,
			UIActivity.ActivityType.postToFlickr,
			UIActivity.ActivityType.postToVimeo,
			UIActivity.ActivityType.postToTencentWeibo,
		]

		self.viewController.present(activityViewController, animated: true, completion: nil)
	}

}
