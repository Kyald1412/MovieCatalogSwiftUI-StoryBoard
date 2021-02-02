//
//  ContentViewModel.swift
//  MovieCatalog-Swiftui
//
//  Created by Dhiky Aldwiansyah on 02/02/21.
//

import Foundation
import Moya
import Combine

class ContentViewModel : ObservableObject {
    
    @Published var popularMovies : [MovieData] = []

    private lazy var provider = MoyaProvider<Endpoints>()

    func loadPopularMovies() {
        
        provider.request(.popular) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                do {
                    strongSelf.popularMovies.append(contentsOf: try response.map(Movies.self).results)
                } catch {
                    print("oh error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
