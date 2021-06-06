//
//  RepoCellViewPreview.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import SwiftUI

struct RepoCellViewPreview_Previews: PreviewProvider {
    
    struct Wrapper: UIViewRepresentable {
        
        let cellData: CellData
        
        init(cellData: CellData) {
            self.cellData = cellData
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
            guard let view = uiView as? RepoTableViewCell else { return }
            view.refresh()
        }
        
        func makeUIView(context: Context) -> some UIView {
            return RepoTableViewCell(cellData: self.cellData)
        }
    }
    
    static var previews: some View {
        Group {
            Group {
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClientGithubClientGithubClientGithubClientGithubClient")).previewDisplayName("リポジトリ名が長い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "G")).previewDisplayName("リポジトリ名が短い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", repositoryName: "GithubClient")).previewDisplayName("作者名が長い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "f", repositoryName: "GithubClient")).previewDisplayName("作者名が短い")
                
            }
            .previewDisplayName("iPhone 11 pro")
            .previewLayout(.fixed(width: 390, height: 390 / 5))
            
            Group {
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClientGithubClientGithubClientGithubClientGithubClient")).previewDisplayName("リポジトリ名が長い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "G")).previewDisplayName("リポジトリ名が短い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", repositoryName: "GithubClient")).previewDisplayName("作者名が長い")
                Wrapper(cellData: CellData(profileImageData: nil, ownerName: "f", repositoryName: "GithubClient")).previewDisplayName("作者名が短い")
                
            }
            .previewDisplayName("iPad pro 11inch")
            .previewLayout(.fixed(width: 834, height: 834 / 5))
        }
    }
    static var platform: PreviewPlatform? = .iOS
}
