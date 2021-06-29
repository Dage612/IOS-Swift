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
    @IBOutlet weak var companyLogosStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = self.movieId {
            self.viewModel.getMovieDetail(id: id,  completion: { (movie) in
                DispatchQueue.main.async {
                    self.title = movie.title
                    
                    let urlString = Util.getFullImageUrl(imageUrl: movie.backdropImage!, width: 500)
                    
                    if let posterImageURL = URL(string: urlString) {
                        self.backdropImage.load(url: posterImageURL)
                    }
                    
                    self.titleLabel.text = movie.title
                    self.descriptionLabel.text = movie.overview
                    
                    if let companies = movie.productionCompanies {
                        for company in companies {
                            if let logoPath = company.logoPath {
                                let urlString = Util.getFullImageUrl(imageUrl: logoPath, width: 300)
                                if let logoUrl = URL(string: urlString) {
                                    let image = UIImageView()
                                    image.heightAnchor.constraint(equalToConstant: CGFloat(60)).isActive = true
                                    image.widthAnchor.constraint(equalToConstant: CGFloat(60)).isActive = true
                                    
                                    self.companyLogosStack.addArrangedSubview(image)
                                    image.load(url: logoUrl)
                                   
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    
}
