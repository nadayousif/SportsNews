//
//  League.swift
//  SportsNews
//
//  Created by Nada youssef on 21/05/2023.
//

import Foundation


class League :  Decodable {
    var league_key: Int?
    var league_name: String?
    var country_name: String?
    var league_logo: String?
}

struct LeagueResult :Decodable{
    let success: Int
    let result: [League]?
}


struct LeagueTeams :Decodable{
    let success: Int
    let result: [Team]?
}


struct Team :Decodable{
    var team_key: Int
    var team_name: String?
    var team_logo: String?
    var players:[player]
    var coaches:[Coach]?
    
    init(){
        self.team_key = 0
        self.team_logo = ""
        self.team_name = ""
        self.players = []
        self.coaches = []
    }
}

struct player : Decodable{
    var player_name: String?
    var player_number : String?
    var player_image : String?
    var player_age : String?
    var player_type : String?
}

struct Coach:Decodable{
    let coach_name:String?
}
