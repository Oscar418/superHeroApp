import Moya

/// This is a class created for handling Network requests in Project
struct NetworkAdapter {
    /**
         Call this function for making network calls easily in your View Controller class.
         - Parameters:
            - target : Provides you with options of which endpoint you would like to hit.
         
         ### Usage Example: ###
         ````
            NetworkAdapter.request(target: .superHeroPowers(id: heroID), success: { (response) in }
         ````
         */
    static let provider = MoyaProvider<MyServerAPI>()
    static func request(target: MyServerAPI, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                   let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
