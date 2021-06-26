//
//  ImageLoaderHelper.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 25/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
import UIKit

internal let imageCache = NSCache<NSString, AnyObject>()

internal struct ImageLoaderHelper {

	// Loads image from cache if avialable or else it will download image from given url. The image loaded is returned in completion

	static func loadImageUsingCache(withUrl urlString: String, completionHandler: @escaping ((UIImage?) -> Void)) {
		guard let url: URL = URL(string: urlString) else {
			completionHandler(nil)
			return
		}

		// if cache contains the image, return it
		if let cachedImage: UIImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
			completionHandler(cachedImage)
			return
		}

		// if cache does not contain the image, download image from url
		URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
			if let error: Error = error {
				completionHandler(nil)
				return
			}

			guard let data: Data = data else {
				completionHandler(nil)
				return
			}
			if let image: UIImage = UIImage(data: data) {
				imageCache.setObject(image, forKey: urlString as NSString)
				completionHandler(image)
				return
			} else {
				completionHandler(nil)
				return
			}

		}).resume()
	}
}
