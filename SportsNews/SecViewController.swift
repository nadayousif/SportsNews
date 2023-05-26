//
//  SecViewController.swift
//  SportsNews
//
//  Created by Nada youssef on 24/05/2023.
//

import UIKit

class SecViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var sportKey = Int()
    var sportName = String()
    
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
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
            cell.fristImage.image = UIImage(named: "football.jpg")
            cell.secImage.image = UIImage(named: "football.jpg")
            
            
            return cell
            
        case secCollection :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secCell", for: indexPath) as! SecCollectionViewCell
            cell.secView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            cell.fristTeam.image = UIImage(named: "football.jpg")
            cell.secTeam.image = UIImage(named: "football.jpg")
            return cell
     
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as! ThirdCollectionViewCell
            cell.thirdView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            //cell.imageView.layer.cornerRadius = 40
            //cell.layer.masksToBounds = true
            cell.imageTeam.image = UIImage(named: "football.jpg")
            return cell
            
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
