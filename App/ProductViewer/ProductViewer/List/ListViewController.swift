//
//  ListViewController.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import IntentsUI
import UIKit
import Tempo

class ListViewController: UIViewController {

	static let dealsListActivity = "com.target.productviewer.showdeals"

	override open var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
    
    class func viewControllerFor(coordinator: TempoCoordinator) -> ListViewController {
        let viewController = ListViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    fileprivate var coordinator: TempoCoordinator!
    
    lazy var collectionView: UICollectionView = {
        let harmonyLayout = HarmonyLayout()
        
        harmonyLayout.collectionViewMargins = HarmonyLayoutMargins(top: .half, right: .half, bottom: .half, left: .half)
        harmonyLayout.defaultSectionMargins = HarmonyLayoutMargins(top: .half, right: .none, bottom: .half, left: .none)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: harmonyLayout)
        collectionView.backgroundColor = .targetFadeAwayGrayColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
		collectionView.accessibilityIdentifier = "productsListCollectionView"
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addAndPinSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)

		self.navigationController?.navigationBar.tintColor = .white
		self.title = "Deals"
        
        let components: [ComponentType] = [
            ProductListComponent()
        ]
        
        let componentProvider = ComponentProvider(components: components, dispatcher: coordinator.dispatcher)
        let collectionViewAdapter = CollectionViewAdapter(collectionView: collectionView, componentProvider: componentProvider)
        
        coordinator.presenters = [
            SectionPresenter(adapter: collectionViewAdapter),
        ]
		donateShortcut()
    }

	/**
	Donation for shortcut: Donation for shortcut is made everytime users load the deals page
	( Even if users dont create a Shorcut from the app, this donation will let iOS know that it can suggest users to create a shortcut for this action.
	To test:  Load deals page multiple times. If you go to spotlight search and type deals you will see a suggestion for shortcut as one of the result.
	iOS is completely responsible for time/location/any other factors for suggesting the shortcut to users. )
	*/
	func donateShortcut() {
		if #available(iOS 12.0, *) {
			let dealsActivity = NSUserActivity.showDealsActivity
			self.userActivity = dealsActivity
			dealsActivity.becomeCurrent()
		}
	}
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}


