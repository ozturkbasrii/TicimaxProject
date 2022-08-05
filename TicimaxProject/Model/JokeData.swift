//
//  MemeModel.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 3.08.2022.
//

import Foundation

// MARK: - MemesModel
struct JokeData: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable {
    let id, name: String
    let url: String

}
