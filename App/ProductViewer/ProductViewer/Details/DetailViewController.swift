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

class DetailViewController: UIViewController {

	class func viewControllerFor(coordinator: TempoCoordinator) -> DetailViewController {
		let viewController = DetailViewController()
		viewController.coordinator = coordinator as? DetailCoordinator
		return viewController
	}

	let dispatcher = Dispatcher()

	fileprivate var coordinator: TempoCoordinator!

	var productDetailView : ProductDetailView = {
		let productDetailView = ProductDetailView()
		productDetailView.translatesAutoresizingMaskIntoConstraints = false
		return productDetailView
	}()

	

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.barTintColor = .white
		coordinator.presenters = [ProductDetailPresenter(detailVC:self,
													  dispatcher:coordinator.dispatcher)]
		setupView()
	}

	func setupView() {
		self.view.addSubview(productDetailView)

		productDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		productDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		productDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		productDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}

}
