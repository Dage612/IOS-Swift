//
//  MyFavoritesViewController.swift
//  Rest API
//
//  Created by Olman Mora on 6/24/21.
//  Copyright © 2021 Niso. All rights reserved.
//

import UIKit

class MyFavoritesViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    private var myFavoriteViewModel: MyFavoritesViewModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var favorites: [Favorite] = []
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.favorites = self.myFavoriteViewModel?.getAllFavorites() ?? []
        DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myFavoriteViewModel = MyFavoritesViewModel(context: appDelegate.persistentContainer.viewContext)
        self.favorites = self.myFavoriteViewModel?.getAllFavorites() ?? []
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: MyFavoritesViewCell.identifier, for: indexPath) as! MyFavoritesViewCell
        
        let favorite = self.favorites[indexPath.row]
        
        if let imageUrl = favorite.imageUrl{
            let urlString = Util.getFullImageUrl(imageUrl: imageUrl, width: 200)
            
            if let imageUri = URL(string: urlString) {
                favoriteCell.moviePosterImageView.load(url: imageUri)
                
            }
        }
        
        favoriteCell.movieTitleLabel?.text = favorite.title
        
        
        return favoriteCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Remove") { (action, view, bool) in
            let id = self.favorites[indexPath.row].id
            self.myFavoriteViewModel?.removeFavorite(id: Int(id))
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
      
        
        let swipeAction = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeAction
    }
    

}
