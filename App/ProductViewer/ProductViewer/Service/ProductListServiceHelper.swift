//
//  ProductListServiceHelper.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation
/**
ProductListServiceHelper conforms to protocol composition of RequestHandler and ResponseHandler
An instance of this struct will provide implementations for protocol methods
*/
public struct ProductListServiceHelper: RequestHandler & ResponseHandler {

	/// Resposnse data type for ProductListServiceHelper is Products
	typealias ResponseDataType = Products
	/// URL to be hit to get deals list
	private let dealsURLString = "https://api.target.com/mobile_case_study_deals/v1/deals"

	func getRequest(from param: [String: Any]) -> URLRequest? {
			let urlString = dealsURLString
			if var url = URL(string: urlString) {
				if param.count > 0 {
					url = setQueryParams(parameters: param, url: url)
				}
				var urlRequest = URLRequest(url: url)
				setDefaultHeaders(request: &urlRequest)
				urlRequest.httpMethod = "GET"
				return urlRequest
			}
			return nil
		}

	func parseResponse(data: Data, response: HTTPURLResponse) throws -> Products {
		return try defaultParseResponse(data: data,response: response)
	}
}
