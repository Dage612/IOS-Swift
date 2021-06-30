//
//  MyFavoritesViewModel.swift
//  NoteAppCoreData
//
//  Created by Olman Mora on 29/6/21.
//

import Foundation
import CoreData

class MyFavoritesViewModel{
    private let context: NSManagedObjectContext
    private let entityName = "Favorite"
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveFavorite(id: Int, title: String, imageUrl: String){
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        do {
            let results = try self.context.fetch(request)
            
            if results.isEmpty {
                let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.context)
                let newFavorite = Favorite(entity: entity!, insertInto: context)
                newFavorite.id = Int32(id)
                newFavorite.title = title
                newFavorite.imageUrl = imageUrl
                do
                {
                    try context.save()
                }
                catch
                {
                    print("context save error")
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
    func removeFavorite(id: Int){
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        do {
            let results = try self.context.fetch(request)
            
            if !results.isEmpty {
                
                for result in results{
                    context.delete(result as! NSManagedObject)
                    try context.save()
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
    func isMovieFavorite(id:Int) -> Bool {
        let predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        do {
            let results = try self.context.fetch(request)
            return !results.isEmpty
        }
        catch
        {
            print("Fetch Failed")
            
        }
        
        return false
    }
    
    func getAllFavorites() -> [Favorite]
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try context.fetch(request) as? [Favorite] ?? []
            return results
        }
        catch
        {
            print("Fetch Failed")
        }
        
        return []
    }
}
