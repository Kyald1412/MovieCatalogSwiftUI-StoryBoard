//
//  ContentView.swift
//  MovieCatalog-Swiftui
//
//  Created by Dhiky Aldwiansyah on 02/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.popularMovies.count > 0 {
                
                List(viewModel.popularMovies) { movie in
                    VStack.init(alignment: .leading, spacing: 10, content: {
                        
                        WebImage(url: URL(string: Endpoints.posterUrl + movie.backdropPath)!)
                            .resizable()
                            .indicator(Indicator.progress)
                            .aspectRatio(2,contentMode: .fit)
                            .transition(.fade)
                     
                        Text(movie.title)
                        Text(movie.overview)
                    }).padding()
                    
                }
              
            } else {
                Text("Loading \(viewModel.popularMovies.count)")
            }
            
            
        }.onAppear(perform: {
            viewModel.loadPopularMovies()
        })
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
