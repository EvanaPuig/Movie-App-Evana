//  
//  PopularService.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class CategoriesListService: CategoriesListServiceProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Call protocol function

    func getPopularMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ()) {

        let url = MovieAppConstants.popularURL
            
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey : MovieAppConstants.apiKeyValue, MovieAppConstants.parameterPage: pageNumber],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType : MovieAppConstants.headerContentType],
            completion: { data in
                // mapping data
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }
                    
                    let managedObjectContext = self.persistentContainer.viewContext
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    let decoded = try decoder.decode(SearchResult.self, from: data)
                    try managedObjectContext.save()
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }

    }
    
    func getTopRatedMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ()) {
        
        let url = MovieAppConstants.topRatedURL
        
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey : MovieAppConstants.apiKeyValue, MovieAppConstants.parameterPage: pageNumber],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType : MovieAppConstants.headerContentType],
            completion: { data in
                // mapping data
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }
                    
                    let managedObjectContext = self.persistentContainer.viewContext
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    let decoded = try decoder.decode(SearchResult.self, from: data)
                    try managedObjectContext.save()
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }
        
    }
    
    func getUpcomingMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ()) {
        
        let url = MovieAppConstants.upcomingURL
        
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey : MovieAppConstants.apiKeyValue, MovieAppConstants.parameterPage: pageNumber],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType : MovieAppConstants.headerContentType],
            completion: { data in
                // mapping data
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }
                    
                    let managedObjectContext = self.persistentContainer.viewContext
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    let decoded = try decoder.decode(SearchResult.self, from: data)
                    try managedObjectContext.save()
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }
        
    }
    
    func getConfiguration(success: @escaping(_ data: Configuration) -> (), failure: @escaping() -> ()) {
        
        let url = MovieAppConstants.configurationURL
        
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey: MovieAppConstants.apiKeyValue],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType: MovieAppConstants.headerContentTypeValue],
            completion: { data in
                // mapping data
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }
                    
                    let managedObjectContext = self.persistentContainer.viewContext
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    let decoded = try decoder.decode(Configuration.self, from: data)
                    try managedObjectContext.save()
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }
        
    }

}
