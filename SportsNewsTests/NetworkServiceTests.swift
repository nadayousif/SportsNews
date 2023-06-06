//
//  NetworkServiceTests.swift
//  SportsNewsTests
//
//  Created by Nada youssef on 04/06/2023.
//

import XCTest
@testable import SportsNews
final class NetworkServiceTests: XCTestCase {
    let networkManager = NetworkingService()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetDataFromURL(){
        let myExpectation = expectation(description: "waiting for the API")
        
        NetworkingService.getData(leagueName: "football"){ result in
            guard let result = result else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(result.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetTeamsFromURL(){
        let myExpectation = expectation(description: "waiting for the API")
        
        NetworkingService.getTeams(sportName: "football", leagueId:152 ){ result in
            guard let result = result else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(result.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetUpcomingFixturesFromURL(){
        let myExpectation = expectation(description: "waiting for the API")
        
        NetworkingService.getUpcomingFixtures(sportName: "football", leagueId:152){ result in
            guard let result = result else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(result.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetLatestResultFromURL(){
        let myExpectation = expectation(description: "waiting for the API")
        
        NetworkingService.getLatestResult(sportName: "football", leagueId: 152){ result in
            guard let result = result else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(result.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetPlayerResultFromURL(){
        let myExpectation = expectation(description: "waiting for the API")
        
        NetworkingService.getPlayerResult(sportName: "football", leagueId: 152, teamId: 80){ result in
            guard let result = result else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertGreaterThan(result.count, 0, "Array is Empty")
            //XCTAssertEqual(items.count, 0, "Array is not Empty")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

