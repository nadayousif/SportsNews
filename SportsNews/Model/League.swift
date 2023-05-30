//
//  League.swift
//  SportsNews
//
//  Created by Nada youssef on 21/05/2023.
//

import Foundation


class League {
    var league_key: Int?
    var league_name: String?
    var country_name: String?
    var league_logo: String?
}

struct LeagueTeams {
    let success: Int
    let result: [Team]?
}


struct Team{
    var team_key: Int
    var team_name: String?
    var team_logo: String?
    
    init(){
        self.team_key = 0
        self.team_logo = ""
        self.team_name = ""
    }
    

}
