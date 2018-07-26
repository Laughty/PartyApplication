//
//  FriendsServices.swift
//  PartyAppTests
//
//  Created by user1 on 25.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import XCTest
import CoreData
@testable import PartyApp

class FriendsServices: XCTestCase {
    
    var friendsServices: FriendsServices!
    
    override func setUp() {
        super.setUp()
        
        friendsServices = FriendsServices()
        
    }
    
    override func tearDown() {
        
        friendsServices = nil
        
        super.tearDown()
    }
    
    func testFriendServicesCoreData() {
        let managedObjectContext = setUpInMemoryManagedObjectContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Friends", into: managedObjectContext)
        
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
    
}
