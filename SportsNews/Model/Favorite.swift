//
//  Favorite.swift
//  SportsNews
//
//  Created by Nada youssef on 01/06/2023.
//

import Foundation

class FavoriteTeams {
    var teamLogo:String
    var teamName:String
    var  teamId:Int
    var  leagueId:Int
    var sportType:String
    init(teamLogo: String, teamName: String, teamId: Int, leagueId: Int, sportType: String) {
        self.teamLogo = teamLogo
        self.teamName = teamName
        self.teamId = teamId
        self.leagueId = leagueId
        self.sportType = sportType
    }
}
