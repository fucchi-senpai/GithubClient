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
            guard let view = uiView as? RepoCellView else { return }
            view.refresh()
        }
        
        func makeUIView(context: Context) -> some UIView {
            return RepoCellView(cellData: self.cellData)
        }
    }
    
    static var previews: some View {
        Group {
            Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClientGithubClientGithubClientGithubClientGithubClient")).previewDisplayName("リポジトリ名が長い")
            Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "G")).previewDisplayName("リポジトリ名が短い")
            Wrapper(cellData: CellData(profileImageData: nil, ownerName: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", repositoryName: "GithubClient")).previewDisplayName("作者名が長い")
            Wrapper(cellData: CellData(profileImageData: nil, ownerName: "f", repositoryName: "GithubClient")).previewDisplayName("作者名が短い")
            
        }
        .previewLayout(.fixed(width: 480, height: 100))
    }
    static var platform: PreviewPlatform? = .iOS
}
