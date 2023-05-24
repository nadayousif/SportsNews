//
//  LeagueTableViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 21/05/2023.
//

import UIKit
import SDWebImage
class LeagueTableViewController: UITableViewController {
    var league = String()
    var leagueArray:[League]?
    var networkIndicator : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        var leagueName = league
        leagueArray = [League]()
        print("in table \(leagueName)")
        networkIndicator = UIActivityIndicatorView(style: .large)
                networkIndicator!.color = UIColor.red
                networkIndicator!.center = view.center
                networkIndicator!.startAnimating()
                view.addSubview(networkIndicator!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        var url = URL(string: "")
        switch leagueName {
        case "Football":
            url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98")
            
        case "Basketball":
            url = URL(string: "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98")
            
        case "Cricket":
            url = URL(string: "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98")
            
            
        default:
            url = URL(string: "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=fc142f1a9f4bd0d8feb642e74313246f65e869f3262027d2bb4eed0d9d0fac98")
            
        }
        
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: req){data,response,error in
            var json = try? JSONSerialization.jsonObject(with: data!) as?
            Dictionary<String,Any>
            var dataArr = json!["result"] as! Array<Dictionary<String,Any>>
            var dataDic = dataArr[0] as! Dictionary<String,Any>
            var empName = dataDic["league_name"] as! String
            print("nada")
            print(empName)
            for rawLeague in dataArr {
                let leagueObj = League()
                leagueObj.league_name = rawLeague["league_name"] as? String
                leagueObj.country_name = rawLeague["country_name"] as? String
                leagueObj.league_key = rawLeague["league_key"] as? Int
                leagueObj.league_logo = rawLeague["league_logo"] as? String
                self.leagueArray?.append(leagueObj)
            }
          
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.networkIndicator!.stopAnimating()

            }
        
            
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueArray!.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! TableViewCell
        //cell.imageView?.image = nil
        /*cell.textLabel?.text = leagueArray![indexPath.row].league_name
        // Configure the cell...
        cell.detailTextLabel?.text = ""
        if(leagueArray![indexPath.row].league_logo != nil){
            let url = URL(string: leagueArray![indexPath.row].league_logo!)
            cell.imageView?.sd_setImage(with: url,completed: nil)
            } else {
                cell.imageView?.image = UIImage(named: "default.jpg")
            }*/
        
        cell.labelLeague.text = leagueArray![indexPath.row].league_name
        if(leagueArray![indexPath.row].league_logo != nil){
            let url = URL(string: leagueArray![indexPath.row].league_logo!)
            cell.imageLeague?.sd_setImage(with: url,completed: nil)
            } else {
                cell.imageLeague?.image = UIImage(named: "default.jpg")
            }
       
      
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
