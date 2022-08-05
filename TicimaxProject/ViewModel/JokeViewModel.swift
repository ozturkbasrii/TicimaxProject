//
//  MemeViewModel.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 3.08.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelProtocol {
    
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func load()
    func memes(index: Int) -> Meme?
    

}

protocol ViewModelDelegate: AnyObject {
    func reloadData()
}

final class JokeViewModel {
    
    var meme : [Meme] = []
    let memeRequest = MemesRequest()
    weak var delegate: ViewModelDelegate?
    
    let items = PublishSubject<[Meme]>()
    
    func fetchMemes() {
        memeRequest.getMemes{ result in
                    switch result {
                    case .success(let memeList):
                        self.meme = memeList
                        self.delegate?.reloadData()
                        self.items.onNext(self.meme)
                        self.items.onCompleted()
                        print(self.meme)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
        


    }

    
}
extension JokeViewModel: ViewModelProtocol {
    func memes(index: Int) -> Meme? {
        meme[index]
    }
    
    
    var numberOfItems: Int {
        meme.count
    }

    func load() {
        fetchMemes()
    }
    
    
    
}
