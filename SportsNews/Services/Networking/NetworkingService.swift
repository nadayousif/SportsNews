//
//  NetworkingService.swift
//  SportsNews
//
//  Created by Nada youssef on 28/05/2023.
//

import Foundation

class NetworkingService {
    static func getData(leagueName: String, completion: @escaping ([League]?) -> Void) {
        guard let url = URL(string: "https://apiv2.allsportsapi.com/\(leagueName)/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98") else {
            completion(nil)
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else {
                    completion(nil)
                    return
                }
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let dataArr = json["result"] as? [[String: Any]] else {
                    completion(nil)
                    return
                }
                var leagueArray: [League] = []
                for rawLeague in dataArr {
                    let leagueObj = League()
                    leagueObj.league_name = rawLeague["league_name"] as? String
                    leagueObj.country_name = rawLeague["country_name"] as? String
                    leagueObj.league_key = rawLeague["league_key"] as? Int
                    leagueObj.league_logo = rawLeague["league_logo"] as? String
                    leagueArray.append(leagueObj)
                }
                completion(leagueArray)
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    static func getTeams(sportName: String, leagueId: Int, completion: @escaping ([Team]?) -> Void) {
        if sportName != "tennis" {
            let urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&leagueId=\(leagueId)"
            guard let url = URL(string: urlTeam) else {
                completion(nil)
                return
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                do {
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        completion(nil)
                        return
                    }
                    guard let result = json["result"] as? [[String: Any]] else {
                        completion(nil)
                        return
                    }
                    var teamArray = [Team]()
                    for rawTeam in result {
                        var teamObj = Team()
                        teamObj.team_key = rawTeam["team_key"] as? Int ?? 0
                        teamObj.team_logo = rawTeam["team_logo"] as? String
                        teamObj.team_name = rawTeam["team_name"] as? String
                        teamArray.append(teamObj)
                    }
                    completion(teamArray)
                } catch {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
    static func getUpcomingFixtures(sportName: String, leagueId: Int, compilition: @escaping ([Event]?) -> Void) {
        var urlTeam = ""
        switch sportName {
        case "football":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2023-05-23&to=2023-06-30&leagueId=\(leagueId)"
        case "basketball":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2023-01-23&to=2023-12-30&leagueId=\(leagueId)"
        case "cricket":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2022-01-23&to=2023-12-30&leagueId=\(leagueId)"
        default:
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2020-05-23&to=2025-06-30&leagueId=\(leagueId)"
        }

        guard let url = URL(string: urlTeam) else {
            compilition(nil)
            return
        }

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                guard let data = data else {
                    compilition(nil)
                    return
                }

                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    compilition(nil)
                    return
                }
                guard let result = json["result"] as? [[String: Any]] else {
                    compilition(nil)
                    return
                }
                var upcomingArray = [Event]()
                for rawLeague in result {
                    var leagueObj = Event()
                    switch sportName {
                    case "football":
                        leagueObj.home_team_logo = rawLeague["home_team_logo"] as? String
                        leagueObj.away_team_logo = rawLeague["away_team_logo"] as? String
                        leagueObj.event_date = rawLeague["event_date"] as? String
                        leagueObj.event_time = rawLeague["event_time"] as? String
                        leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                        leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                    case "basketball":
                        leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                        leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                        leagueObj.event_date = rawLeague["event_date"] as? String
                        leagueObj.event_time = rawLeague["event_time"] as? String
                        leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                        leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                    case "cricket":
                        leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                        leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                        leagueObj.event_date_start = rawLeague["event_date_start"] as? String
                        leagueObj.event_time = rawLeague["event_time"] as? String
                        leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                        leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                    default:
                        leagueObj.event_first_player_logo = rawLeague["event_first_player_logo"] as? String
                        leagueObj.event_second_player_logo = rawLeague["event_second_player_logo"] as? String
                        leagueObj.event_date = rawLeague["event_date"] as? String
                        leagueObj.event_time = rawLeague["event_time"] as? String
                        leagueObj.event_first_player = rawLeague["event_first_player"] as? String
                        leagueObj.event_second_player = rawLeague["event_second_player"] as? String
                    }
                    upcomingArray.append(leagueObj)
                }
                compilition(upcomingArray)
            } catch {
                print("Error: \(error.localizedDescription)")
                compilition(nil)
            }
        })
        task.resume()
    }
    static func getLatestResult(sportName: String, leagueId: Int, compilition: @escaping ([Event]?) -> Void) {
        var urlTeam = ""
        switch sportName {
        case "football":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2023-05-23&to=2023-06-30&leagueId=\(leagueId)"
        case "basketball":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2023-01-23&to=2023-12-30&leagueId=\(leagueId)"
        case "cricket":
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2022-01-23&to=2023-12-30&leagueId=\(leagueId)"
        default:
            urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&from=2020-05-23&to=2025-06-30&leagueId=\(leagueId)"
        }
        guard let url = URL(string: urlTeam) else {
            // If URL is invalid, call completion block with nil and return
            compilition(nil)
            return
        }
        let req = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
            do {
                guard let data = data else {
                    // If no data is returned, call completion block with nil and return
                    compilition(nil)
                    return
                }
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                var dataArr: [[String: Any]] = []
                if let result = json?["result"] as? [[String: Any]] {
                    dataArr = result
                }
                var upcomingArray: [Event] = []
                for rawLeague in dataArr {
                    var leagueObj = Event()
                    leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                    leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                    leagueObj.event_date = rawLeague["event_date"] as? String
                    leagueObj.event_time = rawLeague["event_time"] as? String
                    leagueObj.home_team_logo = rawLeague["home_team_logo"] as? String
                    leagueObj.away_team_logo = rawLeague["away_team_logo"] as? String
                    leagueObj.event_final_result = rawLeague["event_final_result"] as? String
                    leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                    leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                    leagueObj.event_home_final_result = rawLeague["event_home_final_result"] as? String
                    leagueObj.event_first_player = rawLeague["event_first_player"] as? String
                    leagueObj.event_second_player = rawLeague["event_second_player"] as? String
                    leagueObj.event_first_player_logo = rawLeague["event_first_player_logo"] as? String
                    leagueObj.event_second_player_logo = rawLeague["event_second_player_logo"] as? String
                    
                    upcomingArray.append(leagueObj)
                }
                
                compilition(upcomingArray)
            } catch {
                // If an error occurs, call completion block with nil
                compilition(nil)
            }
        })
        task.resume()
    }
    static func getPlayerResult(sportName: String,leagueId:Int,teamId:Int,compilition : @escaping([Team]?) -> Void){
        var urlTeam = ""
             urlTeam =
            "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&leagueId=\(leagueId)&teamId=\(teamId)"
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req){
                  data,response,error in
                  do{
                     if let data = data{
                         let result = try? JSONDecoder().decode(LeagueTeams.self,from: data)
                         compilition(result?.result!)
                      }
                  }catch{
                      print("no data")
                  }
              }
              task.resume()
      }
}
