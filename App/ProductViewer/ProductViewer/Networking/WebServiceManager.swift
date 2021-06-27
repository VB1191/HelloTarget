//
//  WebServiceManager.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

/**
WebServiceManager is responsible for making API call and returning response
*/
struct WebServiceManager<T: RequestHandler & ResponseHandler> {
	var serviceHelper: T
	var urlSession: URLSession

	/// Inits with a helper that conforms to RequestHandler & ResponseHandler, urlSession defaulted to .default
	init(serviceHelper: T, urlSession: URLSession = .shared) {
		self.serviceHelper = serviceHelper
		self.urlSession = urlSession
	}

	/// Loads the data from generic serviceHelper's URL and parses response based on its ResponseDataType
	func loadAPIRequest(requestData: [String: Any], completionHandler: @escaping (T.ResponseDataType?, NetworkError?) -> ()) {

		/// Get the URL request
		guard let urlRequest = serviceHelper.getRequest(from: requestData) else {
			completionHandler(nil, NetworkError.urlRequestEmpty)
			return
		}

		/// get datatTask
		let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in

			guard let httpResponse = response as? HTTPURLResponse  else {
				completionHandler(nil, NetworkError.badResponseReceived)
				return
			}

			guard error == nil else {
				completionHandler(nil, NetworkError.badResponseReceived)
				return
			}

			guard let responseData = data else {
				completionHandler(nil, NetworkError.emptyDataSent)
				return
			}

			do {
				let parsedResponse = try self.serviceHelper.parseResponse(data: responseData, response: httpResponse)
				completionHandler(parsedResponse, nil)
			} catch {
				completionHandler(nil, NetworkError.serializationFailure)
			}

		}

		task.resume()
	}
}
