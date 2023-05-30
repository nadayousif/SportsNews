//
//  TeamDetailsViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 26/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
 
    
    
    @IBOutlet weak var teamCollection: UICollectionView!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var teamName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teamCollection.dataSource = self
        teamCollection.delegate = self
        teamImage.image = UIImage(named: "football.jpg")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
        /*cell.fristView.layer.cornerRadius = 40
        cell.layer.masksToBounds = true
        cell.fristImage.image = UIImage(named: "football.jpg")
        cell.secImage.image = UIImage(named: "football.jpg")*/
        cell.teamView.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.playerPhoto.image = UIImage(named: "football.jpg")
        
        return cell
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
