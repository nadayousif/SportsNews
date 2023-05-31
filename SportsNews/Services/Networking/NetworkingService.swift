//
//  NetworkingService.swift
//  SportsNews
//
//  Created by Nada youssef on 28/05/2023.
//

import Foundation

class NetworkingService {
    static func getData(leagueName: String,compilition : @escaping([League]?) -> Void){
        var url = URL(string: "")
        url = URL(string: "https://apiv2.allsportsapi.com/\(leagueName)/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98")
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
            var json = try? JSONSerialization.jsonObject(with: data!) as?
            Dictionary<String,Any>
            var dataArr = json!["result"] as! Array<Dictionary<String,Any>>
            var dataDic = dataArr[0] as! Dictionary<String,Any>
            var empName = dataDic["league_name"] as! String
            print("nada")
            print(empName)
            var leagueArray:[League]?
            leagueArray = [League]()
            for rawLeague in dataArr {
                let leagueObj = League()
                leagueObj.league_name = rawLeague["league_name"] as? String
                leagueObj.country_name = rawLeague["country_name"] as? String
                leagueObj.league_key = rawLeague["league_key"] as? Int
                print(leagueObj.league_key)
                print(leagueObj.league_name)
                leagueObj.league_logo = rawLeague["league_logo"] as? String
                leagueArray?.append(leagueObj)
            }
            compilition(leagueArray)
        })
        task.resume()
    }
    
    static func getTeams(sportName: String,leagueId:Int,compilition : @escaping([Team]?) -> Void){
        //  print(sportName)
        //print(leagueId)
        if sportName != "tennis" {
            var urlTeam = "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98&leagueId=\(leagueId)"
            var url = URL(string: urlTeam)
            let req = URLRequest(url: url!)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                var json = try? JSONSerialization.jsonObject(with: data!) as?
                Dictionary<String,Any>
                var dataArr : [Dictionary<String, Any>]
                if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                    dataArr = result
                    // use dataArr as needed
                } else {
                    dataArr = []
                }
            
                var teamArray:[Team]?
                teamArray = [Team]()
                for rawLeague in dataArr {
                    var leagueObj = Team()
                    leagueObj.team_key = (rawLeague["team_key"] as? Int)!
                    leagueObj.team_logo = rawLeague["team_logo"] as? String
                    leagueObj.team_name = rawLeague["team_name"] as? String
                    teamArray?.append(leagueObj)
                }
                compilition(teamArray)
                
            })
            
            task.resume()
        }
    
    }
    
    
    
    
    static func getUpcomingFixtures(sportName: String,leagueId:Int,compilition : @escaping([Event]?) -> Void){
        var urlTeam = ""
        switch (sportName){
        case "football" :
             urlTeam =
               "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2023-05-23&to=2023-06-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.home_team_logo = rawLeague["home_team_logo"] as? String
                      leagueObj.away_team_logo = rawLeague["away_team_logo"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
        case "basketball" :
            urlTeam =
              "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2023-01-23&to=2023-12-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                      leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
        case "cricket" :
            urlTeam =
              "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2022-01-23&to=2023-12-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                      leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                      leagueObj.event_date_start = rawLeague["event_date_start"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
        default :
            urlTeam =
              "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2020-05-23&to=2025-06-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_first_player_logo = rawLeague["event_first_player_logo"] as? String
                      leagueObj.event_second_player_logo = rawLeague["event_second_player_logo"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_first_player = rawLeague["event_first_player"] as? String
                      leagueObj.event_second_player = rawLeague["event_second_player"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
            
        }

    }
    
    static func getLatestResult(sportName: String,leagueId:Int,compilition : @escaping([Event]?) -> Void){
        var urlTeam = ""
        switch (sportName){
        case "football" :
             urlTeam =
            "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2023-05-23&to=2023-06-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.home_team_logo = rawLeague["home_team_logo"] as? String
                      leagueObj.away_team_logo = rawLeague["away_team_logo"] as? String
                      leagueObj.event_final_result = rawLeague["event_final_result"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
            
        case "basketball" :
            urlTeam =
            "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2023-01-23&to=2023-12-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                      leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                      leagueObj.event_final_result = rawLeague["event_final_result"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
            
        case "cricket" :
            urlTeam =
              "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2022-01-23&to=2023-12-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_home_team = rawLeague["event_home_team"] as? String
                      leagueObj.event_away_team = rawLeague["event_away_team"] as? String
                      leagueObj.event_date_start = rawLeague["event_date_start"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_home_team_logo = rawLeague["event_home_team_logo"] as? String
                      leagueObj.event_away_team_logo = rawLeague["event_away_team_logo"] as? String
                      leagueObj.event_home_final_result = rawLeague["event_home_final_result"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
            
        default :
            urlTeam =
            "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&from=2020-05-23&to=2025-06-30&leagueId=\(leagueId)"
            
              var url = URL(string: urlTeam)
              let req = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: req,completionHandler:{(data,response,error) in
                  var json = try? JSONSerialization.jsonObject(with: data!) as?
                  Dictionary<String,Any>
                  var dataArr : [Dictionary<String, Any>]
                  if let result = json!["result"] as? Array<Dictionary<String, Any>>  {
                      dataArr = result
                  } else {
                      dataArr = []
                  }
               
                  var upcomingArray:[Event]?
                  upcomingArray = [Event]()
                  for rawLeague in dataArr {
                      var leagueObj = Event()
                      leagueObj.event_first_player = rawLeague["event_first_player"] as? String
                      leagueObj.event_second_player = rawLeague["event_second_player"] as? String
                      leagueObj.event_date = rawLeague["event_date"] as? String
                      leagueObj.event_time = (rawLeague["event_time"] as? String)!
                      leagueObj.event_first_player_logo = rawLeague["event_first_player_logo"] as? String
                      leagueObj.event_second_player_logo = rawLeague["event_second_player_logo"] as? String
                      leagueObj.event_final_result = rawLeague["event_final_result"] as? String
                      upcomingArray?.append(leagueObj)
                  }
                  compilition(upcomingArray)
                  
              })
              
              task.resume()
            
        }
     
    }
    
    
    static func getPlayerResult(sportName: String,leagueId:Int,teamId:Int,compilition : @escaping([Team]?) -> Void){
        var urlTeam = ""
             urlTeam =
            "https://apiv2.allsportsapi.com/\(sportName)/?&met=Teams&APIkey=73c2f608d71c07237af2b5e3b4f14237cf16a8f5fe0257f5e95c24171967b1fc&leagueId=\(leagueId)&teamId=\(teamId)"
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
