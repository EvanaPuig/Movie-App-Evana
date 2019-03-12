//
//  APIManager.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import Alamofire


struct APIManager {
    
    static var manager: SessionManager!
    
    /// GET FROM API
    ///
    /// - Parameters:
    ///   - url: URL API
    ///   - method: methods
    ///   - parameters: parameters
    ///   - encoding: encoding
    ///   - headers: headers
    ///   - completion: completion
    ///   - failure: failure
    static func request(_ url: String, method: HTTPMethod, parameters: Parameters, encoding: ParameterEncoding, headers: HTTPHeaders, completion: @escaping (_ response: Data) ->(), failure: @escaping (_ error: String, _ errorCode: Int) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
        
        let apiURL = MovieAppConstants.movieDBApiURL + url
        print("-- URL API: \(apiURL), \n\n-- headers: \(headers), \n\n-- Parameters: \(parameters)")
        
        manager.request(
            apiURL,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers).responseString(
                queue: DispatchQueue.main,
                encoding: String.Encoding.utf8) { response in
                    
                    //print("--\n \n CALLBACK RESPONSE: \(response)")
                    
                    if response.response?.statusCode == 200 {
                        guard let callback = response.data else {
                            failure(self.generateRandomError(), 0)
                            return
                        }
                        completion(callback)
                        
                    } else if response.response?.statusCode == 401 {
                        // add function automatically logout app
                    } else {
                        guard let callbackError = response.data else {
                            return
                        }
                        
                        print("MAP GLOBAL ERROR FOR: \(callbackError)" )
                    }
        }
        
    }
    
    /// GENERATE RANDOM ERROR
    ///
    /// - Returns: string error randoms
    static func generateRandomError() -> String {
        return MovieAppConstants.genericError
    }
    
}
