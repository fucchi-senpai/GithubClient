//
//  RepoDetailViewPreview.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/06.
//

import SwiftUI


struct RepoDetailViewPreview_Previews: PreviewProvider {
    struct Wrapper: UIViewRepresentable {
        
        let userData: CellData
        
        init(userData: CellData) {
            self.userData = userData
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
            guard let view = uiView as? RepoDetailView else { return }
            view.refresh()
        }
        
        func makeUIView(context: Context) -> some UIView {
            return RepoDetailView(userData: self.userData)
        }
    }
    
    static var previews: some View {
        Group {
            Group {
                Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "This is repository Github Client", starCount: "2"))
                    .previewDisplayName("通常レイアウト")
                Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", repositoryName: "GithubClient", aboutRepository: "This is repository Github Client", starCount: "2"))
                    .previewDisplayName("作者名が長い")
                Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClientGithubClientGithubClientGithubClientGithubClientGithubClient", aboutRepository: "This is repository Github Client", starCount: "2"))
                    .previewDisplayName("リポジトリ名が長い")
                Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "This is repository Github ClientThis is repository Github ClientThis is repository Github ClientThis is repository Github ClientThis is repository Github ClientThis is repository Github ClientThis is repository Github Client", starCount: "2"))
                    .previewDisplayName("リポジトリ説明が長い")
                Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "This is repository Github Client", starCount: "99999999999999999999999999999999999999999"))
                    .previewDisplayName("スターがとんでもなく多い")
            }
            .previewLayout(.fixed(width: 390, height: 200))
        }
    }
}
