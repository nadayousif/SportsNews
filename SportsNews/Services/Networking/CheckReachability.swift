//
//  CheckReachability.swift
//  SportsNews
//
//  Created by Nada youssef on 02/06/2023.
//

import Foundation
import UIKit
class CheckReachability {
    
    
    
    func alertNetworking()->UIAlertController{
        let alert = UIAlertController(title: "Alert", message: "No network", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
       // self.present(alert, animated: true, completion: nil)
        return alert
    }
}
