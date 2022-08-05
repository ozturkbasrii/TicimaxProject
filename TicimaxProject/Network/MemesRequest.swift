import Foundation

enum MemesRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct MemesRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://api.imgflip.com/get_memes"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    func getMemes(completion : @escaping(Result<[Meme],MemesRequestError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let memes = try decoder.decode(JokeData.self, from: jsonData)
                completion(.success(memes.data.memes))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
