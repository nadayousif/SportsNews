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
        var dataBaseService :DataBaseService
   
    init(sportType: String, teamId: Int, teamName:String,leagueId:Int,teamLogo:String,view: TeamDetailsProtocol, networkService: NetworkingService,dataBaseService :DataBaseService) {
            self.sportType = sportType
            self.teamId = teamId
            self.teamName = teamName
            self.leagueId = leagueId
            self.teamLogo = teamLogo
            self.view = view
            self.dataBaseService = dataBaseService
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
    
    
    func addTeamToFavorites(teamName:String , teamImage:String){
    
        dataBaseService.insertTeam(data: FavoriteTeams(teamLogo: teamLogo, teamName: teamName, teamId: teamId, leagueId: leagueId, sportType: sportType)) { [weak self] success in
            if success {
                print("success")
                print("in team presenter \(teamName)")
            }else {
                print("fail")
            }
        }
    }
}
