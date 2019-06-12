//
//  TrackHeaderView.swift
//  musiclist
//
//  Created by Artem Shuba on 12/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import SwiftUI

struct TrackHeaderView : View {
    let track: Track
    
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: track.getCoverImage() ?? UIImage())
                .resizable()
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(track.title ?? "")
                    .font(.system(size: 17)
                ).bold()
                
                Text(track.artist ?? "")
                    .font(.system(size: 13))
                    .opacity(0.6)
            }
        }
    }
}

#if DEBUG
struct TrackHeaderView_Previews : PreviewProvider {
    static var previews: some View {
        TrackHeaderView()
    }
}
#endif
