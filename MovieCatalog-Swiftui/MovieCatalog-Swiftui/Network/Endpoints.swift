//
//  Movies.swift
//  MovieCatalog
//
//  Created by Dhiky Aldwiansyah on 02/02/21.
//

import Foundation
import Moya

public enum Endpoints {
    static let apiKey = "a1583e56b778bf2dc5234bebc273d364"
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let posterUrl = "https://image.tmdb.org/t/p/w500"

    case popular
}

extension Endpoints: TargetType {
    
    public var baseURL: URL {
        return URL(string: Endpoints.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .popular : return "/popular"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        let authParams = ["api_key": Endpoints.apiKey]
        
        switch self {
        case .popular:
            return .requestParameters(parameters: authParams, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
