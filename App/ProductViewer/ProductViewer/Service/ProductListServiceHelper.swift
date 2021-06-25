//
//  ProductListServiceHelper.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

public struct ProductListServiceHelper: RequestHandler & ResponseHandler {

	typealias ResponseDataType = Products

	func getRequest(from param: [String: Any]) -> URLRequest? {
			let urlString =  "https://api.target.com/mobile_case_study_deals/v1/deals"
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
