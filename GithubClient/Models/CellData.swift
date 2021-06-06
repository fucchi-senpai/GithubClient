//
//  CellData.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//
import Foundation

struct CellData {
    var profileImageData: Data?
    var ownerName: String
    var repositoryName: String
    var aboutRepository: String = ""
    var starCount: String = "0"
}
