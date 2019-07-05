//
//  MovieListTableViewController.swift
//  MovieDatabaseOBJC
//
//  Created by Jason Mandozzi on 7/5/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    var movies: [JBMMovie] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}

        let movieItem = movies[indexPath.row]
        
        
        
        cell.titleLabel.text = movieItem.title
        cell.ratingLabel.text = String("\(movieItem.rating)")
        cell.descriptionTextView.text = movieItem.overview
        
//        JBMMovieController.sharedInstance().fetchImage(movieItem) { (image) in
//            DispatchQueue.main.async {
//                cell.posterImageView.image = image
//            }
//        }
        

        return cell
    }
    

    
}
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchBar.text, searchTerm != "" else {return}
        JBMMovieController.sharedInstance().fetchMovie(withSearch: searchTerm) { (MovieItemsFromCompletion) in
            self.movies = MovieItemsFromCompletion
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
}
