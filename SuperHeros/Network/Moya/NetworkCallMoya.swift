import Foundation
import Moya

enum MyServerAPI {
    case superHeroImage(id: Int)
    case superHeroInfo(id: Int)
    case superHeroPowers(id: Int)
}

extension MyServerAPI: TargetType {
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "https://superheroapi.com/api/753573865272812")! }
    
    var path: String {
        switch self {
        case .superHeroImage(let id):
            return "/\(id)/image"
        case .superHeroInfo(let id):
            return "/\(id)/biography"
        case .superHeroPowers(let id):
            return "/\(id)/powerstats"
        }
    }
  
    var method: Moya.Method {
        switch self {
        case .superHeroImage:
            return .get
        case .superHeroInfo:
            return .get
        case .superHeroPowers:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
  
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}
