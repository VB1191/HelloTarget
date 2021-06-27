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

	fileprivate func updateUI() {
		for presenter in presenters {
			presenter.present(viewState)
		}
	}
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
		/// Goes to product details on click of item. Since product details shows same data as seen on list, new API call isnt made.
		/// Same details are passed to details page
        dispatcher.addObserver(ListItemPressed.self) { [weak self] listViewStateEvent in
			let detailCoordinator = DetailCoordinator(previousViewState: listViewStateEvent.selectedViewState)
			self?.viewController.navigationController?.pushViewController(detailCoordinator.viewController, animated: true)
        }
    }

	/// Updates the view state that was initially craeted by calling API and fetching results
    func updateState() {

		fetchProductsList() { (products, error) in
			if let errorFound = error {
				print("Error: Fetching products error \(errorFound)") // Ideally send to splunk
				let alert = UIAlertController(title: "Uh-oh Something went wrong", message: "Please try again later", preferredStyle: .alert)
				alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil) )
				self.viewController.present(alert, animated: true, completion: nil)
			} else {

				let productsObject: Products? = products

				guard let productsArray: [Product] =  productsObject?.products else {
					return
				}

				var viewStateItems = [ListItemViewState]()
				for product in productsArray {
					let viewStateItem = ListItemViewState(
						title: NSLocalizedString(product.title, comment: ""),
						salePrice: product.salePrice?.displayString ?? "",
						originalPrice: product.regularPrice.displayString,
						image: UIImage(named: "targetGray"),
						aisle: "Asile\n\(product.aisle)",
						imageURL: product.imageUrl,
						description: product.description
					)
					viewStateItems.append(viewStateItem)
				}

				self.viewState.listItems = viewStateItems
			}
		}
    }

	/// fetches products list with tge help of ProductListServiceHelper and WebServiceManager
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
