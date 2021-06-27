//
//  DetailViewController.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import Tempo
import UIKit

/**
View controller that displays product details view
*/
class DetailViewController: UIViewController {

	/// Dispatcher for any new events recieved
	let dispatcher = Dispatcher()

	/// Coordinator that handles this View controller
	fileprivate var coordinator: TempoCoordinator!

	/// main View for the view controller
	var productDetailView : ProductDetailView = {
		let productDetailView = ProductDetailView()
		productDetailView.translatesAutoresizingMaskIntoConstraints = false
		return productDetailView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.barTintColor = .white

		let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

		self.navigationItem.rightBarButtonItem = shareBar

		/// set's up presenter for the coordinator
		coordinator.presenters = [ProductDetailPresenter(detailVC:self,
													  dispatcher:coordinator.dispatcher)]
		setupView()
	}

	/// Returns DetailViewController with coordinator set
	class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
		let viewController = DetailViewController()
		viewController.coordinator = coordinator as? DetailCoordinator
		return viewController
	}

	func setupView() {
		self.view.addSubview(productDetailView)

		productDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		productDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		productDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		productDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}

	@objc func shareTapped() {
		guard let presenter = coordinator.presenters.first as? ProductDetailPresenter else {
			return
		}
		presenter.shareButtonClicked()
	}

}
