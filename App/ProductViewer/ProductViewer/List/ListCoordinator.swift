//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    
    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
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
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e in
            let alert = UIAlertController(title: "Item selected!", message: "🐶", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
            self?.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateState() {

		fetchProductsList() { (model, error) in
			if let errorFound = error {
				print("Error")
			} else {

				let productsObject: Products? = model

				guard let productsArray: [Product] =  productsObject?.products else {
					return
				}

				var viewStateItems = [ListItemViewState]()
				for product in productsArray {
					let viewStateItem = ListItemViewState(
						title: NSLocalizedString(product.title, comment: ""),
						salePrice: product.salePrice?.displayString ?? "",
						originalPrice: product.regularPrice.displayString,
						image: UIImage(named: "\(1)"),
						aisle: "Asile\n\(product.aisle)",
						imageURL: product.imageUrl
					)
					viewStateItems.append(viewStateItem)
				}

				self.viewState.listItems = viewStateItems
			}
		}


		/* 2. Load from mock
		let productsObject: Products? = MockProductsList().mockProducts

		guard let productsArray: [Product] =  productsObject?.products else {
			return
		}

		var viewStateItems = [ListItemViewState]()
		for product in productsArray {
			let viewStateItem = ListItemViewState(title: NSLocalizedString(product.title, comment: ""), price: product.regularPrice.displayString, image: UIImage(named: "\(1)"))
			viewStateItems.append(viewStateItem)
		}

		viewState.listItems = viewStateItems
		*/

		// 1. initial
//        viewState.listItems = (1..<10).map { index in
//            ListItemViewState(title: "Puppies!!!", price: "$9.99", image: UIImage(named: "\(index)"))
//        }
    }


	func fetchProductsList(param: [String: Any] = [:], completion: @escaping (Products?, NetworkError?) -> ()) {
		let productListServiceHelper = ProductListServiceHelper()

		let webServiceManager = WebServiceManager(serviceHelper: productListServiceHelper)
		webServiceManager.loadAPIRequest(requestData: param) { (model, error) in
			if let _ = error {
				completion(nil, error)
			} else {
				completion(model, nil)
			}
		}
	}
}
