//
//  ResponseHandler.swift
//  ProductViewer
//
//  Created by Bhatt, Vidhi on 24/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Foundation

internal enum NetworkError: Error {
	case emptyDataSent
	case emptyResults
	case serializationFailure
	case serverError
	case badResponseReceived
	case urlRequestEmpty
}

/**
ResponseHandler protocol helps in parsing Data into the associatedtype
*/
protocol ResponseHandler {
	associatedtype ResponseDataType
	func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

extension ResponseHandler {

	/// Parses given Data and checks for valid HTTPURLResponse code and returns associatedtype in case of success
	func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
		let jsonDecoder = JSONDecoder()
		do {
			/// decode Data
			let body = try jsonDecoder.decode(T.self, from: data)
			guard response.statusCode == 200 else {
				throw NetworkError.serverError
			}
			return body
		} catch  {
			throw NetworkError.serializationFailure
		}

	}
}

