//
//  ViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 19/05/2023.
//

import UIKit
import SDWebImage
import Reachability
protocol ViewControllerProtocol : AnyObject{
    func updateFavoriteView(data: [FavoriteTeams])
    func updateDeleteItem(itemIndexPath:Int)

}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,ViewControllerProtocol{
 
    
    @IBOutlet weak var favoriteTabel: UITableView!
    var favoritePresenter:FavoritePresenter?
    var favoriteArray=[FavoriteTeams]()
    let loadingNetworkIndicator=UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        favoriteTabel.dataSource = self
        favoriteTabel.delegate = self
        self.favoritePresenter?.getAllFavoriteTeams()
      
        print("nada")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("before delete")
            self.updateDeleteItem(itemIndexPath: indexPath.row)
           // tableView.deleteRows(at: [indexPath], with: .fade)
            print("after delete")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.favoriteView.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        cell.labelName.text = favoriteArray[indexPath.row].teamName
        cell.teamId.text = String(describing: favoriteArray[indexPath.row].teamId)
        cell.imageFavorite.sd_setImage(with: URL(string: (favoriteArray[indexPath.row].teamLogo) ), placeholderImage: UIImage(named: "logo.png"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reachability = try? Reachability()
        if reachability?.connection  ==  .unavailable{
            let alert = UIAlertController(title: "Alert", message: "No Networking", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            favoritePresenter?.navigateToTeamDetailsScreen(teamId: favoriteArray[indexPath.row].teamId,sportName:favoriteArray[indexPath.row].sportType,teamName:favoriteArray[indexPath.row].teamName,leagueId: favoriteArray[indexPath.row].leagueId, teamLogo:favoriteArray[indexPath.row].teamLogo,view: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           print("will appear")
         
           favoriteArray=[FavoriteTeams]()
           
           favoritePresenter = FavoritePresenter(view: self,dataBaseService: DataBaseService.getInstance)
           favoritePresenter?.getAllFavoriteTeams()
      
           
       }
    
    func updateFavoriteView(data: [FavoriteTeams]){
        self.loadingNetworkIndicator.stopAnimating()
            self.favoriteArray=data
        print("in view \(data.last?.teamName)")
            self.favoriteTabel.reloadData()
           
    }
    
    func updateDeleteItem(itemIndexPath:Int){
        let selectedTeam=(favoriteArray[itemIndexPath])
       
        self.confirmationForDelete(itemIndexPath: itemIndexPath, selectedTeam: selectedTeam)
        /*self.favoritePresenter?.deleteTeam(itemIndexPath: itemIndexPath, teamId: selectedTeam.teamId)
        self.favoriteArray.remove(at: itemIndexPath)
        self.favoriteTabel.reloadData()*/
        print("delete from view\(itemIndexPath)")

    }
    
    
    
    
   /* @objc func buttonTapped(_ sender: UIButton) {
               let itemIndexPath = IndexPath(row: sender.tag, section: 0)
           let selectedTeam=(favoriteArray[itemIndexPath.row])
           self.confirmationForDelete(itemIndexPath: itemIndexPath, selectedTeam: selectedTeam)
           }*/
       
    func confirmationForDelete(itemIndexPath:Int,selectedTeam:FavoriteTeams){
        let alert=UIAlertController(title: "Confirmation request", message: "Are you sure you want to delete this team from your favorite list?", preferredStyle: .alert)
        let confirm=UIAlertAction(title: "confirm", style: .destructive){[self]
            action in
           self.favoritePresenter?.deleteTeam(itemIndexPath: itemIndexPath, teamId: selectedTeam.teamId)
            self.favoriteArray.remove(at: itemIndexPath)
            self.favoriteTabel.reloadData()
        }
        let cancel=UIAlertAction(title: "Cancel", style: .destructive){[self]
            action in
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
                        topController.present(alert, animated: true, completion: nil)
                    }
        
    }
        
            
            
        
    }
//fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98
/*https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98*/
