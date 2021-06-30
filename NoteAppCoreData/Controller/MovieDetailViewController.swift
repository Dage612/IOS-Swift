//
//  MovieDetauilViewController.swift
//  Rest API
//
//  Created by Olman Mora on 6/24/21.
//  Copyright © 2021 Niso. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieId: Int?
    private var movieDetail: MovieDetail?
    private var viewModel = MovieViewModel()
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var rateLabel: UILabel!
    
    var castList: [Cast] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.castCollectionView.register(CastPersonViewCell.self,forCellWithReuseIdentifier: CastPersonViewCell.identifier)
        
        self.castCollectionView.dataSource = self
        self.castCollectionView.delegate = self
        
        
        if let id = self.movieId {
            self.viewModel.getMovieDetail(id: id,  completion: { (movie) in
                DispatchQueue.main.async {
                    self.title = movie.title
                    
                    if let backdropImage = movie.backdropImage{
                        let urlString = Util.getFullImageUrl(imageUrl: backdropImage, width: 500)
                        
                        if let posterImageURL = URL(string: urlString) {
                            self.backdropImage.load(url: posterImageURL)
                        }
                    }
                    else if let posterPath = movie.posterPath {
                        let urlString = Util.getFullImageUrl(imageUrl: posterPath, width: 500)
                        
                        if let posterImageURL = URL(string: urlString) {
                            self.backdropImage.load(url: posterImageURL)
                        }
                    }
                    
                   
                    
                    self.titleLabel.text = movie.title
                    self.descriptionLabel.text = movie.overview
                    self.rateLabel.text = String(movie.voteAverage)
                    
                    if let releaseDate = movie.releaseDate {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy"
                        self.yearLabel.text = dateFormatter.string(from: releaseDate)
                    }
                    else{
                        self.yearLabel.isHidden = true
                    }
                    
                    
                }
            })
            
            self.viewModel.getMovieCredits(id: id, completion: { (movieCredits) in
                self.castList = movieCredits.cast
                self.castCollectionView.reloadData()
                                           
                                           })
        }
    }
    
    
}

extension MovieDetailViewController : UICollectionViewDelegateFlowLayout {
    
}


extension MovieDetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastPersonViewCell.identifier, for: indexPath) as! CastPersonViewCell
        
        var imageURL: String? = nil
        
        if let profileImage = castList[indexPath.row].profileImage{
            imageURL = Util.getFullImageUrl(imageUrl: profileImage, width: 500)
        }
        
        cell.configure(profileImage: imageURL, profileName: castList[indexPath.row].name)
        
        return cell
    }
    
    
}

extension MovieDetailViewController : UICollectionViewDelegate {
    
}

