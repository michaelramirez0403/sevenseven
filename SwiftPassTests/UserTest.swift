//
//  UserTest.swift
//  SwiftPassTests
//
//  Created by Macky Ramirez on 11/8/24.
//

import XCTest
@testable import SwiftPass
final class UserTest: XCTestCase {
    var coreDataManager: CoreDataManager!
    override func setUp() {
        super.setUp()
        // Use in-memory store for testing
        coreDataManager = CoreDataManager(inMemory: true)
    }
    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }
    // MARK: - Tests saving a profile by calling insertUserDetails and then verifies if the profile is saved by fetching it.
    func testSaveProfile() throws {
        // Test saving a profile
        let user = UsersDetails(email: "johndoe@example.com",
                                password: "Greatpass123")
        let _ = coreDataManager.insertUserDetails(user)
        // Fetch profiles to validate save
        let profiles = coreDataManager.getUserDetails("johndoe@example.com")
        XCTAssertEqual(profiles?.email, user.email, "Email should match the saved profile")
    }
    // MARK: - Tests if profile exist by calling checkIfItemExist and then verifies if the profile returned false
    func testIfUserExists() throws {
        // Checking if username name already exist in coredata
        let user = UsersDetails(email: "janedoe@gmail.com",
                                password: "Greatpass1234")
        let profiles = coreDataManager.checkIfItemExist(user.email!, user.password!)
        XCTAssertFalse(profiles, "User doesn't exist. User can be saved to coredata.")
        
    }
    // MARK: -  Tests fetching profiles by adding a profile and then checking that it can be fetched correctly.
    func testFetchUser() throws {
        // Insert a profile to fetch
        let user = UsersDetails(email: "alice@gmail.com",
                                password: "Greatpass1234")
        coreDataManager.insertUserDetails(user)
        // Test fetching profiles
        let profiles = coreDataManager.getUserDetails(user.email!)
        XCTAssertEqual(profiles?.email, user.email, "Email should match the saved profile")
    }
}
