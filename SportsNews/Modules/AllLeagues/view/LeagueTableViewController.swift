//
//  LeagueTableViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 21/05/2023.
//

import UIKit
import SDWebImage
import Reachability
protocol TableProtocol : AnyObject{
    func updateMyTable(data :[League])
}

class LeagueTableViewController: UITableViewController,TableProtocol {
    var tablePresenter : LeagueTablePresenter?
    var league = String()
    var leagueArray:[League]?
    var networkIndicator : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        var leagueName = league
        leagueArray = [League]()
        print("in table \(leagueName)")
        
        let reachability = try? Reachability()
        // try? reachability?.startNotifier()
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
            tablePresenter = LeagueTablePresenter()
            tablePresenter?.attachView(view: self)
            tablePresenter?.getData(leagueName: leagueName)
        }
      
       /* tablePresenter = LeagueTablePresenter()
        tablePresenter?.attachView(view: self)
        tablePresenter?.getData(leagueName: leagueName)*/
        
        
      
    }

    // MARK: - Table view data source

    func updateMyTable(data :[League]){
        leagueArray = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.networkIndicator!.stopAnimating()
        }
    }
    
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
        cell.leagueView.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        if(leagueArray![indexPath.row].league_logo != nil){
            let url = URL(string: leagueArray![indexPath.row].league_logo!)
            cell.imageLeague?.sd_setImage(with: url,completed: nil)
            } else {
                cell.imageLeague?.image = UIImage(named: "logo.png")
            }
       
      
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(leagueArray![indexPath.row].league_name)
        let myLeague = self.storyboard?.instantiateViewController(identifier: "SecScreen") as! SecViewController
        myLeague.sportName = league
        myLeague.sportKey = leagueArray![indexPath.row].league_key!
        self.navigationController?.pushViewController(myLeague, animated: true)
    }*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reachability = try? Reachability()
        if reachability?.connection  ==  .unavailable{
            let alert = UIAlertController(title: "Alert", message: "No Networking", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            tablePresenter?.navigateToLeagueDetailsScreen(leagueID: (leagueArray?[indexPath.row].league_key)!,sportName:league, view: self)
            print("in all league\((leagueArray?[indexPath.row].league_key))")
        }
       
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
