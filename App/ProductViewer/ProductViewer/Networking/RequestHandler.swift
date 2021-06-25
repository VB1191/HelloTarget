//
//  RequestHandler.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

/**
RequestHandler protocol helps in creating a URLRequest
*/
protocol RequestHandler {
	// Constructs and returns optional URLRequest based on paramters passed
	func getRequest(from data:[String: Any]) -> URLRequest?
}

extension RequestHandler {

	// sets query parameters for the url
	func setQueryParams(parameters:[String: Any], url: URL) -> URL {
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
		components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
		return components?.url ?? url
	}

	// sets default headers for the given request
	func setDefaultHeaders(request: inout URLRequest) {
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	}
}
