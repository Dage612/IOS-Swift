//
//  ViewController.swift
//  Rest API
//
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadPopularMoviesData()
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let selected = self.viewModel.cellForRowAt(indexPath: indexPath)
            
            if let vc = segue.destination as? MovieDetailViewController {
                vc.movieId = selected.id
            }
        }
       
    }
}

// MARK: - TableView
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }

}

extension MovieViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.loadPopularMoviesData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText == ""{
            self.loadPopularMoviesData()
        }
        else{
          
                self.viewModel.search(term: searchText, completion: { movies in
                    print(movies)
                    self.tableView.reloadData()
                })
            
        }
    }
    
    
}
