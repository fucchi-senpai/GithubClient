//
//  ProfileViewPreview.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import SwiftUI

struct ProfileViewPreview_Previews: PreviewProvider {
    struct Wrapper: UIViewRepresentable {
        
        let userData: UserEntity
        
        init(userData: UserEntity) {
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
            Wrapper(userData: UserEntity(profileImageUrl: "https://avatars.githubusercontent.com/u/53225198?v=4", name: "fucchi-senpai", bio: "iOS Developer"))
                .previewDisplayName("通常レイアウト")
            Wrapper(userData: UserEntity(profileImageUrl: "https://avatars.githubusercontent.com/u/53225198?v=4", name: "fucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpaifucchi-senpai", bio: "iOS Developer"))
                .previewDisplayName("作者名が長い")
            Wrapper(userData: UserEntity(profileImageUrl: "https://avatars.githubusercontent.com/u/53225198?v=4", name: "fucchi-senpai", bio: "iOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS DeveloperiOS Developer"))
                .previewDisplayName("バイオが長い")
        }
        .previewLayout(.fixed(width: 390, height: 390 * 0.4))
    }
}
