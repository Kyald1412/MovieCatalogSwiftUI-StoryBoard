//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Dhiky Aldwiansyah on 02/02/21.
//

import UIKit
import Foundation
import Moya

class ViewController: UIViewController {
    
    private var state : State = .loading {
        didSet {
            switch state {
            case .failed:
                print("Failed")
            case .ready:
                self.tableView.reloadData()
                print("Ready")
            case .loading:
                print("Loading")
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let provider = MoyaProvider<Endpoints>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        callApiMovies()
    }
    
    func callApiMovies(){
        
        state = .loading
        
        provider.request(.popular) { result in
            switch result {
            case .success(let response):
                do {
                    self.state = .ready(try response.map(Movies.self).results)
                } catch {
                    self.state = .failed
                }
            case .failure( _):
                self.state = .failed
            }
        }
        
    }
    
}

extension ViewController {
    enum State {
        case loading
        case ready([MovieData])
        case failed
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .ready(let movieData) = state else { return 0 }

        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reuseIdentifier, for: indexPath) as? MoviesTableViewCell ?? MoviesTableViewCell()

        guard case .ready(let movieData) = state else { return cell }

        cell.configureWith(movieData[indexPath.item])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

