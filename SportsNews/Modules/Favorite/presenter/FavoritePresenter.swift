//
//  FavoritePresenter.swift
//  SportsNews
//
//  Created by Nada youssef on 01/06/2023.
//

import Foundation

class FavoritePresenter{
        var view:ViewControllerProtocol
        var dataBaseService:DataBaseService
        var databaseResponse = [FavoriteTeams]()
        init(view: ViewControllerProtocol, dataBaseService: DataBaseService) {
            self.view = view
            self.dataBaseService = dataBaseService
        }
    
    func getAllFavoriteTeams() {
            dataBaseService.getAllTeams { [weak self] teams in
                print("in fav presenter")
                print(teams?.last?.teamName)
                print(teams?.count)
          
                self?.databaseResponse = teams ?? []
                self?.view.updateFavoriteView(data: self?.databaseResponse ?? [])
            }
        }
    
    func deleteTeam(itemIndexPath:Int,teamId:Int){
           self.dataBaseService.deleteTeam(teamId: teamId) { [weak self] success in
               if success {
                   print("removed")
               } else {
                   print("cann't remove")
               }
           }
       }
    
    func navigateToTeamDetailsScreen(teamId: Int, sportName: String,teamName:String,leagueId:Int,teamLogo:String,view: ViewController) {
            let teamDetailsView = view.storyboard?.instantiateViewController(identifier: "teams")
            as! TeamDetailsViewController
        let teamDetailsPresenter = TeamDetailsPresenter(sportType: sportName, teamId: teamId,teamName:teamName, leagueId: leagueId,teamLogo:teamLogo,view: teamDetailsView, networkService: NetworkingService(), dataBaseService: DataBaseService.getInstance)
        teamDetailsView.teamDetailPresenter = teamDetailsPresenter
            view.navigationController?.pushViewController(teamDetailsView, animated: true)
        }
}
