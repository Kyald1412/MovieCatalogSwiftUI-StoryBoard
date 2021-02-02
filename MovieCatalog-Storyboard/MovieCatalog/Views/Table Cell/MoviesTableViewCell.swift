//
//  MoviesTableViewCell.swift
//  MovieCatalog
//
//  Created by Dhiky Aldwiansyah on 02/02/21.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier = "MoviesTableViewCell"
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    public func configureWith(_ movieData: MovieData) {
        
        self.lblTitle.text = movieData.title
        self.lblDesc.text = movieData.overview
        
        let imgUrl = URL(string: Endpoints.posterUrl + movieData.backdropPath)
        
        self.img.sd_imageIndicator = SDWebImageProgressIndicator.bar
        self.img.sd_setImage(with: imgUrl, completed: nil)
        
    }
    
}
