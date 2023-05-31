//
//  TeamDetailsPresenter.swift
//  SportsNews
//
//  Created by Nada youssef on 31/05/2023.
//

import Foundation
class TeamDetailsPresenter{
        var sportType:String
        var teamId:Int
        var teamName :String
        var leagueId: Int
        var teamLogo :String
        var view:TeamDetailsProtocol
        var networkService:NetworkingService
        
   
    init(sportType: String, teamId: Int, teamName:String,leagueId:Int,teamLogo:String,view: TeamDetailsProtocol, networkService: NetworkingService) {
            self.sportType = sportType
            self.teamId = teamId
            self.teamName = teamName
            self.leagueId = leagueId
            self.teamLogo = teamLogo
            self.view = view
            self.networkService = networkService
            print(sportType)
           
        }
    func getTeamPlayer() {
        if self.sportType == "football"{
        NetworkingService.getPlayerResult(sportName: sportType, leagueId: leagueId, teamId: teamId){ result in
            if let recivedata = result {
               
                    self.view.updateAllPlayer(data: recivedata)
                    
                }
               
            }
        }
        else{
            self.view.updateSpecialAllPlayer()
        }
    }
}
