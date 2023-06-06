//
//  MockNetworkManager.swift
//  SportsNewsTests
//
//  Created by Nada youssef on 05/06/2023.
//

import Foundation
@testable import SportsNews
class MockNetworkManager {
    var shouldReturnError: Bool
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
   
    //let mockItemsJSONResponse =
 
    enum ResponseWithError : Error {
        case responseError
    }
}

extension MockNetworkManager  {
    func getData(leagueName: String,compilition : @escaping([League]?) -> Void){
        if shouldReturnError{
            compilition(nil )
        }else{
            if let myData = ApiResponse.sportAllLeaguesResponse.data(using: .utf8){
                            do{
                                let result = try JSONDecoder().decode(LeagueResult.self, from: myData)
                                compilition(result.result)
                            }catch let error {
                                print(error.localizedDescription)
                                compilition(nil)
                            }
                    }
        }
    }
    
    
    func getTeams(sportName: String,leagueId:Int,compilition : @escaping([Team]?) -> Void) {
        if shouldReturnError{
            compilition(nil )
        }else{
            if let myData = ApiResponse.leagueTeamsResponse.data(using: .utf8){
                            do{
                                let result = try JSONDecoder().decode(LeagueTeams.self, from: myData)
                                compilition(result.result)
                            }catch let error {
                                print(error.localizedDescription)
                                compilition(nil)
                            }
                    }
        }
    }
    
    func getUpcomingFixtures(sportName: String,leagueId:Int,compilition : @escaping([Event]?) -> Void) {
        if shouldReturnError{
            compilition(nil )
        }else{
            if let myData = ApiResponse.upcomingFixtureResponse.data(using: .utf8){
                            do{
                                let result = try JSONDecoder().decode(eventsLeague.self, from: myData)
                                compilition(result.result)
                            }catch let error {
                                print(error.localizedDescription)
                                compilition(nil)
                            }
                    }
        }
    }
    
    func getLatestResult(sportName: String,leagueId:Int,compilition : @escaping([Event]?) -> Void) {
        if shouldReturnError{
            compilition(nil )
        }else{
            if let myData = ApiResponse.latestResultResponse.data(using: .utf8){
                            do{
                                let result = try JSONDecoder().decode(eventsLeague.self, from: myData)
                                compilition(result.result)
                            }catch let error {
                                print(error.localizedDescription)
                                compilition(nil)
                            }
                    }
        }
    }
    
    func getPlayerResult(sportName: String,leagueId:Int,teamId:Int,compilition : @escaping([Team]?) -> Void) {
        if shouldReturnError{
            compilition(nil )
        }else{
            if let myData = ApiResponse.teamDetailsResponse.data(using: .utf8){
                            do{
                                let result = try JSONDecoder().decode(LeagueTeams.self, from: myData)
                                compilition(result.result)
                            }catch let error {
                                print(error.localizedDescription)
                                compilition(nil)
                            }
                    }
        }
    }
}
