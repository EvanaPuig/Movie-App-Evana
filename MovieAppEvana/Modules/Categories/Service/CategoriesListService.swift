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
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error as NSError? {
                print("Unresolved error \(error)")
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
                    decoded.unique_id = 0
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
                    decoded.unique_id = 2
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
                    decoded.unique_id = 1
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
    
    func loadPersistedConfiguration() -> [Configuration]?{
        let request = Configuration.createFetchRequest()
        
        do {
            let managedObjectContext = self.persistentContainer.viewContext
            let configuration = try managedObjectContext.fetch(request)
            print(configuration)
            return configuration
        } catch {
            print("Fetch failed")
            return nil
        }
    }
    
    func loadSavedData() -> [SearchResult]?{
        let request = SearchResult.createFetchRequest()
        let sort = NSSortDescriptor(key: "unique_id", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            let managedObjectContext = self.persistentContainer.viewContext
            let searchResults = try managedObjectContext.fetch(request)
            return searchResults
        } catch {
            print("Fetch failed")
            return nil
        }
    }

}
