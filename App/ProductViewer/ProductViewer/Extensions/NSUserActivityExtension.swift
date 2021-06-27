//
//  NSUserActivityExtension.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 26/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import CoreSpotlight // SearchableAttributeSet
import MobileCoreServices

/// Enum that can keep track of all different styles of nsuseractivity
enum NSUserActivityStyle {
	case showTargetDeals
}

extension NSUserActivity {

	struct ActivityTypes {
		static let showTargetDeals = "com.target.productviewer.showdeals"
	}

	struct ActivityTitles {
		static let dealsTitle = NSLocalizedString("Show deals", comment: "Show deals")
	}

	struct SearchableDescription {
		static let dealsDescription = NSLocalizedString("Show deals", comment: "Show deals")
	}

	struct InvocationPhrase {
		static let dealsPhrase = NSLocalizedString("Show deals", comment: "Show deals")
	}

	@available (iOS 12.0, *)
	static var showDealsActivity: NSUserActivity {
		let activity = NSUserActivity(activityType: ActivityTypes.showTargetDeals)
		activity.persistentIdentifier =
			NSUserActivityPersistentIdentifier(ActivityTypes.showTargetDeals)
		// If you change this key, existing shortcut will not work until app donates new shortcut with new key.
		activity.isEligibleForSearch = true
		activity.isEligibleForPrediction = true
		let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
		attributes.contentDescription = SearchableDescription.dealsDescription
		activity.suggestedInvocationPhrase = InvocationPhrase.dealsPhrase
		activity.title = ActivityTitles.dealsTitle
		activity.contentAttributeSet = attributes
		return activity
	}
}
