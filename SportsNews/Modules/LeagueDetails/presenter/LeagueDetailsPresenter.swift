//
//  LeagueDetailsPresenter.swift
//  SportsNews
//
//  Created by Nada youssef on 28/05/2023.
//

import Foundation
class LeagueDetailsPresenter{
    var sportType:String
    var leagueId:Int
    var view:SecViewProtocol
    var networkService:NetworkingService
    init(sportType: String, leagueId: Int, view: SecViewProtocol, networkService: NetworkingService) {
        self.sportType = sportType
        self.leagueId = leagueId
        self.view = view
        self.networkService = networkService
        print(sportType)
        print(leagueId)
    }
    
    func getLeagueTeams() {
        if sportType != "tennis"{
            NetworkingService.getTeams(sportName: sportType, leagueId: leagueId) {
                result in
                if let recivedata = result {
                    self.view.updateAllTeams(data: recivedata)
                }
            }
            
        }else{
            self.view.updateAllTeams(data: [])
        }
    }
    func getUpcomingFixture() {
        NetworkingService.getUpcomingFixtures(sportName: sportType, leagueId: leagueId){ result in
            if let recivedata = result {
                let upcomingData = self.prepareUpcomingData(data: recivedata)
                self.view.updateUpcoming(data: upcomingData!)
            }
        }
    }
    func getLatestResult() {
        NetworkingService.getLatestResult(sportName: sportType, leagueId: leagueId){ result in
            if let recivedata = result {
                let latestData = self.prepareLatestGamesData(data: recivedata)
                self.view.updateLatestResult(data: latestData!)
            }
        }
    }
        
        func getScreendata() {
            self.getLeagueTeams()
            self.getUpcomingFixture()
            self.getLatestResult()
        }
        
        func prepareTeamsData(data: [Event]?) -> [League]? {
            if let recivedData = data {
                var dataArray = [League]()
                for team in recivedData {
                    dataArray.append(League())
                }
                return dataArray
            }else {
                return nil
            }
        }
    func prepareUpcomingData(data:[Event]?) -> [UpcomingDisplayedData]? {
        if let recivedData = data {
            var dataArray=[UpcomingDisplayedData]()
            for match in recivedData {
                switch(sportType) {
                case "football":
                    dataArray.append(UpcomingDisplayedData(firstTeamImage: match.home_team_logo, secondTeamImage: match.away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, date: match.event_date, time: match.event_time))
                case "basketball" :
                    dataArray.append(UpcomingDisplayedData(firstTeamImage: match.event_home_team_logo, secondTeamImage: match.event_away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, date: match.event_date, time: match.event_time))
                case "cricket" :
                    dataArray.append(UpcomingDisplayedData(firstTeamImage: match.event_home_team_logo, secondTeamImage: match.event_away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, date: match.event_date_start, time: match.event_time))
                default :
                    dataArray.append(UpcomingDisplayedData(firstTeamImage: match.event_first_player_logo, secondTeamImage: match.event_second_player_logo, firstTeamName: match.event_first_player, secondTeamName: match.event_second_player, date: match.event_date, time: match.event_time))
                }
            }
            return dataArray
        }else {
            return nil
        }
    }
     
    
    
    func prepareLatestGamesData(data: [Event]?) -> [LatestResultDisplayedData]? {
        if let recivedData = data {
            var dataArray=[LatestResultDisplayedData]()
            for match in recivedData {
                switch(sportType) {
                case "football" :
                    dataArray.append(LatestResultDisplayedData(firstTeamImage: match.home_team_logo, secondTeamImage: match.away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, matchResult: match.event_final_result))
                case "basketball" :
                    dataArray.append(LatestResultDisplayedData(firstTeamImage: match.event_home_team_logo, secondTeamImage: match.event_away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, matchResult: match.event_final_result))
                case "cricket" :
                    dataArray.append(LatestResultDisplayedData(firstTeamImage: match.event_home_team_logo, secondTeamImage: match.event_away_team_logo, firstTeamName: match.event_home_team, secondTeamName: match.event_away_team, matchResult: match.event_home_final_result))
                default :
                    dataArray.append(LatestResultDisplayedData(firstTeamImage: match.event_first_player_logo, secondTeamImage: match.event_second_player_logo, firstTeamName: match.event_first_player, secondTeamName: match.event_second_player, matchResult: match.event_final_result))
                }
            }
            return dataArray
        }else {
            return nil
        }
    }
    
    
    
    func navigateToTeamDetailsScreen(teamId: Int, sportName: String,teamName:String,leagueId:Int,teamLogo:String,view: SecViewController) {
            let teamDetailsView = view.storyboard?.instantiateViewController(identifier: "teams")
            as! TeamDetailsViewController
        let teamDetailsPresenter = TeamDetailsPresenter(sportType: sportName, teamId: teamId,teamName:teamName, leagueId: leagueId,teamLogo:teamLogo,view: teamDetailsView, networkService: NetworkingService())
        teamDetailsView.teamDetailPresenter = teamDetailsPresenter
            view.navigationController?.pushViewController(teamDetailsView, animated: true)
        }
    
}
