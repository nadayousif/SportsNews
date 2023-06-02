//
//  SecViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 24/05/2023.
//

import UIKit
import SDWebImage
import Reachability
protocol SecViewProtocol : AnyObject{
    //func updateMyTable(data :[League])
    func updateAllTeams (data : [Team])
    func updateUpcoming(data : [UpcomingDisplayedData])
    func updateLatestResult(data : [LatestResultDisplayedData])
}
class SecViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SecViewProtocol {
    
    var networkIndicator : UIActivityIndicatorView?
    var leagueDetailPresenter:LeagueDetailsPresenter?
    var teamsArray=[Team]()
    var upcomingArray=[UpcomingDisplayedData]()
    var latestArray=[LatestResultDisplayedData]()
    
    
    @IBOutlet weak var fristCollection: UICollectionView!
    
    @IBOutlet weak var secCollection: UICollectionView!
    
    @IBOutlet weak var thirdCollection: UICollectionView!
    //@IBOutlet weak var thirdCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        fristCollection.dataSource = self
        fristCollection.delegate = self
        secCollection.dataSource = self
        secCollection.delegate = self
        thirdCollection.dataSource = self
        thirdCollection.delegate = self
 
        let reachability = try? Reachability()
        if reachability?.connection  ==  .unavailable{
            let alert = UIAlertController(title: "Alert", message: "No Networking", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            networkIndicator = UIActivityIndicatorView(style: .large)
                    networkIndicator!.color = UIColor.red
                    networkIndicator!.center = view.center
                    networkIndicator!.startAnimating()
                    view.addSubview(networkIndicator!)
            self.leagueDetailPresenter?.getLeagueTeams()
            self.leagueDetailPresenter?.getUpcomingFixture()
            self.leagueDetailPresenter?.getLatestResult()
        }
    
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (collectionView){
        case fristCollection :
            return self.upcomingArray.count
        case secCollection:
            return self.latestArray.count
        default:
            return self.teamsArray.count
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

          return CGSize(width: fristCollection.frame.size.width/2, height: fristCollection.frame.size.height)

 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch(collectionView) {
        case fristCollection :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fristCell", for: indexPath) as! FristCollectionViewCell
            cell.fristView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            
            cell.fristName.text = self.upcomingArray[indexPath.row].firstTeamName
            cell.secName.text = self.upcomingArray[indexPath.row].secondTeamName
            cell.dateLabel.text = self.upcomingArray[indexPath.row].date
            cell.myTime.text = self.upcomingArray[indexPath.row].time
            cell.fristImage.sd_setImage(with: URL(string: self.upcomingArray[indexPath.row].firstTeamImage ?? ""), placeholderImage: UIImage(named: "logo.png"))
            cell.secImage.sd_setImage(with: URL(string: self.upcomingArray[indexPath.row].secondTeamImage ?? ""), placeholderImage: UIImage(named: "logo.png"))
            
            return cell
            
        case secCollection :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secCell", for: indexPath) as! SecCollectionViewCell
            cell.secView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            cell.fristTeam.sd_setImage(with: URL(string: self.latestArray[indexPath.row].firstTeamImage ?? ""), placeholderImage: UIImage(named: "logo.png"))
            cell.secTeam.sd_setImage(with: URL(string: self.latestArray[indexPath.row].secondTeamImage ?? ""), placeholderImage: UIImage(named: "logo.png"))
            cell.result.text = self.latestArray[indexPath.row].matchResult
            cell.fristName.text = self.latestArray[indexPath.row].firstTeamName
            cell.secName.text = self.latestArray[indexPath.row].secondTeamName
            return cell
     
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as! ThirdCollectionViewCell
            cell.thirdView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            //cell.imageView.layer.cornerRadius = 40
            //cell.layer.masksToBounds = true
            cell.imageTeam.sd_setImage(with: URL(string: self.teamsArray[indexPath.row].team_logo ?? ""), placeholderImage: UIImage(named: "logo.png"))
            return cell
            
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let reachability = try? Reachability()
         if reachability?.connection  ==  .unavailable{
             let alert = UIAlertController(title: "Alert", message: "No Networking", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }else{
             switch(collectionView) {
             case  thirdCollection:
                 print("to team details")
                 leagueDetailPresenter?.navigateToTeamDetailsScreen(teamId: (teamsArray[indexPath.row].team_key),sportName:leagueDetailPresenter?.sportType ?? "football",teamName:(teamsArray[indexPath.row].team_name)!,leagueId: leagueDetailPresenter!.leagueId, teamLogo:teamsArray[indexPath.row].team_logo!,view: self)
                 /*let myTeam = self.storyboard?.instantiateViewController(identifier: "teams") as! TeamDetailsViewController
                  
                  self.navigationController?.pushViewController(myTeam, animated: true)*/
                 
             default:
                 print("no another view")
             }
             
         }
    }
    
    func updateAllTeams(data teams: [Team]) {
        if teams.isEmpty {
            print("teams are empty")
        }else{
            self.teamsArray = teams
            DispatchQueue.main.async {
                self.thirdCollection.reloadData()
                self.networkIndicator!.stopAnimating()
            }
        }
    }
    
    func updateUpcoming(data upcoming: [UpcomingDisplayedData]) {
        if upcoming.isEmpty {
            print("upcoming are empty")
        }else{
            self.upcomingArray = upcoming
            DispatchQueue.main.async {
                self.fristCollection.reloadData()
                self.networkIndicator!.stopAnimating()
            }
        }
    }
    
    func updateLatestResult(data latest : [LatestResultDisplayedData]){
        if latest.isEmpty {
            print("latest are empty")
        }else{
            self.latestArray = latest
            DispatchQueue.main.async {
                self.secCollection.reloadData()
                self.networkIndicator!.stopAnimating()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
