//
//  ProfileViewPreview.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import SwiftUI

struct ProfileViewPreview_Previews: PreviewProvider {
    struct Wrapper: UIViewRepresentable {
        
        let userData: CellData
        
        init(userData: CellData) {
            self.userData = userData
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
            guard let view = uiView as? ProfileView else { return }
            view.refresh()
        }
        
        func makeUIView(context: Context) -> some UIView {
            return ProfileView(userData: self.userData)
        }
    }
    
    static var previews: some View {
        Group {
            Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "iOS Developer", starCount: "2"))
                .previewDisplayName("通常レイアウト")
            Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", repositoryName: "GithubClient", aboutRepository: "iOS Developer", starCount: "2"))
                .previewDisplayName("作者名が長い")
            Wrapper(userData: CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "iOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS Developer", starCount: "2"))
                .previewDisplayName("バイオが長い")
        }
        .previewLayout(.fixed(width: 390, height: 390 * 0.4))
    }
}
