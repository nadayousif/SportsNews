//
//  LeagueTablePresenter.swift
//  SportsNews
//
//  Created by Nada youssef on 28/05/2023.
//

import Foundation
class LeagueTablePresenter{
  
    
    weak var view : TableProtocol!
    var networkData : [League]!
    func attachView(view: TableProtocol){
        self.view = view
    }
    
    func getData(leagueName:String){
        NetworkingService.getData (leagueName: leagueName ){
            [weak self] leagueArray in self?.view.updateMyTable(data:leagueArray!)
            self?.networkData=leagueArray
        }
    }
    
    func navigateToLeagueDetailsScreen(leagueID: Int, sportName: String,view: LeagueTableViewController) {
            let leagueDetailsView = view.storyboard?.instantiateViewController(identifier: "SecScreen")
            as! SecViewController
        let leagueDetailsPresenter = LeagueDetailsPresenter(sportType: sportName, leagueId: leagueID, view: leagueDetailsView, networkService: NetworkingService(),dataBaseService: DataBaseService.getInstance)
            leagueDetailsView.leagueDetailPresenter = leagueDetailsPresenter
            view.navigationController?.pushViewController(leagueDetailsView, animated: true)
        }
    
    func searchInLeagues(with characters: String) {
            let filteredArray=self.networkData.filter { league in
                return league.league_name!.contains(characters.replacingOccurrences(of: " ", with: ""))
            }
            view?.searchInLeagues(result: filteredArray)
        }
        
        func finalSearching() {
             view?.endSearching(result: networkData)
        }
}
