//
//  LeagueDetails.swift
//  SportsNews
//
//  Created by Nada youssef on 24/05/2023.
//

import Foundation


class Event {
   // var event_key: Int?
    var event_date: String?
    var event_date_start: String?
    var event_time: String?
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    var country_name: String?
    var league_name: String?
   // var league_key: Int?
  //  var league_round: String?
//    var league_season: String?
//    var event_live: String?
 //   var event_stadium: String?
  //  var event_referee: String?
    var home_team_logo: String?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    var away_team_logo: String?
  //  var event_country_key: Int?
  //  var league_logo: String?
   // var country_logo: String?
    var event_first_player_logo: String?
        var event_second_player_logo: String?
 // teniss
        var event_first_player: String?
        var event_second_player: String?
  //cricket
        var event_home_final_result : String?
        var event_away_final_result : String?
}


struct UpcomingDisplayedData{
    let firstTeamImage:String?
    let secondTeamImage:String?
    let firstTeamName:String?
    let secondTeamName:String?
    let date:String?
    let time:String?
}

struct LatestResultDisplayedData{
    let firstTeamImage:String?
    let secondTeamImage:String?
    let firstTeamName:String?
    let secondTeamName:String?
    let matchResult:String?
}
