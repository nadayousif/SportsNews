//
//  DataBaseService.swift
//  SportsNews
//
//  Created by Nada youssef on 01/06/2023.
//

import Foundation

import UIKit
import CoreData

class DataBaseService{
    let context: NSManagedObjectContext?
    static let getInstance=DataBaseService()
   private init() {
      
       let appDelegate=UIApplication.shared.delegate as! AppDelegate
       context=appDelegate.persistentContainer.viewContext
    }
    
    func insertTeam(data:FavoriteTeams,completion : @escaping (Bool)-> Void){
        let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "FavoriteItems")
        let predicate = NSPredicate(format: "teamId == %d", data.teamId)
        fetchRequest.predicate=predicate
        do{
            let existingTeams = try context?.fetch(fetchRequest)
            if existingTeams?.isEmpty ?? true {
                let entity=NSEntityDescription.entity(forEntityName: "FavoriteItems", in: context!)
                let team=NSManagedObject(entity: entity!, insertInto: context)
                team.setValue(data.teamName, forKey: "teamName")
                team.setValue(data.teamLogo, forKey: "teamLogo")
                team.setValue(data.leagueId, forKey: "leagueId")
                team.setValue(data.teamId, forKey: "teamId")
                team.setValue(data.sportType, forKey: "sportType")
                try  context?.save()
                print("added")
                print("in database service \(data.teamName)")
                completion(true)
            }else{
                print("The item already exists")
                completion(false)
            }
            
            }catch{
                print("an error occured in add")
                completion(false)
            }
    }
     
    
    func deleteTeam(teamId:Int , completion : @escaping (Bool)-> Void){
        let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "FavoriteItems")
        let predicate=NSPredicate(format: "teamId == %d",teamId)
        fetchRequest.predicate=predicate
        do {
            let teams=try context!.fetch(fetchRequest)
             context!.delete(teams[0])
             try context!.save()
            completion(true)
             print("deleted")
        } catch {
            completion(false)
            print("eroor in delete")
        }
   
    }
 
    func getAllTeams(completion : @escaping ([FavoriteTeams]?)-> Void){
        var retrievedArray=[FavoriteTeams]()
        let fetchRequest=NSFetchRequest<NSManagedObject>(entityName: "FavoriteItems")
        do{
            let teams=try context!.fetch(fetchRequest)
            for team in teams {
                var teamsaved=FavoriteTeams(teamLogo: "", teamName: "", teamId: 0, leagueId: 0, sportType: "")
                teamsaved.teamId=Int(Int32(team.value(forKey: "teamId") as! Int))
                teamsaved.teamName=team.value(forKey: "teamName") as! String
                teamsaved.leagueId=Int(Int32(team.value(forKey: "leagueId") as! Int))
                teamsaved.teamLogo=team.value(forKey: "teamLogo")as! String
                teamsaved.sportType=team.value(forKey: "sportType")as! String
                retrievedArray.append(teamsaved)
                print(teamsaved.teamName)
            }
            print(retrievedArray.count)
            print("get data succsessfully")
            completion(retrievedArray)
        }catch{
            print("error")
            completion(nil)
            
        }
    }
    
}

