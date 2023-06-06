//
//  MockNetworkManagerTest.swift
//  SportsNewsTests
//
//  Created by Nada youssef on 05/06/2023.
//

import XCTest
@testable import SportsNews
final class MockNetworkManagerTest: XCTestCase {
    var networkService : MockNetworkManager?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testgetSportAllLeaguesDataShouldPass(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: false)
        networkService?.getData(leagueName: "football" ,compilition: { response in
            guard let response = response else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(response.count, 0,"Error in retrived array")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
        
    }
   
    func testgetSportAllLeaguesDataShouldFail(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: true)
        networkService?.getData(leagueName: "football" ,compilition:{ response in
            XCTAssertNil(response,"items not equal nil")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
    }

    
    func testgetSportAllTeamsDataShouldPass(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: false)
        networkService?.getTeams(sportName: "football", leagueId: 180, compilition: { response in
            guard let response = response else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(response.count, 0,"Error in retrived array")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
        
    }
   
    func testgetSportAllTeamsDataShouldFail(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: true)
        networkService?.getTeams(sportName: "football", leagueId: 180, compilition:{ response in
            XCTAssertNil(response,"items not equal nil")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
    }
    
    
    
    
    func testgetSportAllUpcomingFixturesShouldPass(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: false)
        networkService?.getUpcomingFixtures(sportName: "football", leagueId: 150, compilition:  { response in
            guard let response = response else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(response.count, 0,"Error in retrived array")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
        
    }
   
    func testgetSportAllUpcomingFixturesShouldFail(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: true)
        networkService?.getUpcomingFixtures(sportName: "football", leagueId: 150, compilition: { response in
            XCTAssertNil(response,"items not equal nil")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
    }
    
    
    func testgetSportAllLatestResultShouldPass(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: false)
        networkService?.getLatestResult(sportName: "football", leagueId: 150, compilition:  { response in
            guard let response = response else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(response.count, 0,"Error in retrived array")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
        
    }
   
    func testgetSportAllLatestResultShouldFail(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: true)
        networkService?.getLatestResult(sportName: "football", leagueId: 150, compilition: { response in
            XCTAssertNil(response,"items not equal nil")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
    }
    
    
    
    func testgetSportAllPlayerResultShouldPass(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: false)
        networkService?.getPlayerResult(sportName: "football", leagueId: 120, teamId: 80, compilition:  { response in
            guard let response = response else {
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(response.count, 0,"Error in retrived array")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
        
    }
   
    func testgetSportAllPlayerResultShouldFail(){
        let myExpectation = expectation(description: "wait for my API response")
        networkService = MockNetworkManager(shouldReturnError: true)
        networkService?.getPlayerResult(sportName: "football", leagueId: 120, teamId: 80, compilition: { response in
            XCTAssertNil(response,"items not equal nil")
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10,handler: nil)
    }
}

