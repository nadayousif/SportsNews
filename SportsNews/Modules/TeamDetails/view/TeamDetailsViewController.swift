//
//  TeamDetailsViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 26/05/2023.
//

import UIKit
import SDWebImage
protocol TeamDetailsProtocol : AnyObject{
    func updateAllPlayer (data : [Team])
    
    func updateSpecialAllPlayer ()
}
class TeamDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,TeamDetailsProtocol  {
 
    var teamDetailPresenter:TeamDetailsPresenter?
    var networkIndicator : UIActivityIndicatorView?
    var teamArray=[Team]()
    var playerArray = [player]()
    var coachArray = [Coach]()
    @IBOutlet weak var teamCollection: UICollectionView!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        networkIndicator = UIActivityIndicatorView(style: .large)
                networkIndicator!.color = UIColor.red
                networkIndicator!.center = view.center
                networkIndicator!.startAnimating()
                view.addSubview(networkIndicator!)

        // Do any additional setup after loading the view.
        teamCollection.dataSource = self
        teamCollection.delegate = self
        self.teamDetailPresenter?.getTeamPlayer()
        /*teamImage.sd_setImage(with: URL(string: self.teamArray[0].team_logo ?? "" ), placeholderImage: UIImage(named: "logo.png"))
        teamName.text = self.teamArray[0].team_name
        var playerObj = player()
        for rawPlayer in teamArray[0].players{
            playerObj.player_name = rawPlayer.player_name
            playerObj.player_number = rawPlayer.player_number
            playerObj.player_image = rawPlayer.player_image
            playerObj.player_age = rawPlayer.player_age
            playerObj.player_type = rawPlayer.player_type
            playerArray.append(playerObj)
        }*/
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
        /*cell.fristView.layer.cornerRadius = 40
        cell.layer.masksToBounds = true
        cell.fristImage.image = UIImage(named: "football.jpg")
        cell.secImage.image = UIImage(named: "football.jpg")*/
        cell.teamView.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.playerPhoto.sd_setImage(with: URL(string: self.playerArray[indexPath.row].player_image ?? "" ), placeholderImage: UIImage(named: "logo.png"))
        cell.playerName.text = self.playerArray[indexPath.row].player_name
        cell.playerAge.text = self.playerArray[indexPath.row].player_age
        cell.playerJob.text = self.playerArray[indexPath.row].player_type
        cell.playerNum.text = self.playerArray[indexPath.row].player_number
        return cell
    }
    func updateAllPlayer(data teams: [Team]) {
        if teams.isEmpty {
            print("teams are empty")
        }else{
            self.teamArray = teams
            self.playerArray = teams[0].players
            self.coachArray = teams[0].coaches!
           
            DispatchQueue.main.async {
                self.teamName.text = teams[0].team_name
                self.teamImage.sd_setImage(with: URL(string: teams[0].team_logo ?? "" ), placeholderImage: UIImage(named: "logo.png"))
                self.coachName.text = self.coachArray[0].coach_name
                self.teamCollection.reloadData()
                self.networkIndicator!.stopAnimating()
            }
        }
    }
    
    func updateSpecialAllPlayer() {
       
            
            DispatchQueue.main.async {
                self.teamName.text = self.teamDetailPresenter?.teamName
                self.teamImage.sd_setImage(with: URL(string: self.teamDetailPresenter?.teamLogo ?? "" ), placeholderImage: UIImage(named: "logo.png"))
                self.networkIndicator!.stopAnimating()
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
