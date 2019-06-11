//
//  TrackItemView.swift
//  musiclist
//
//  Created by Artem Shuba on 11/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import SwiftUI

struct TrackItemView : View {
    let track: Track
    
    var body: some View {
        HStack(spacing: 15) {
            Image(uiImage: track.getCoverImage() ?? UIImage())
                .resizable()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(track.title ?? "")
                    .font(.system(size: 17))
                Text(track.artist ?? "")
                    .font(.system(size: 13))
                    .opacity(0.6)
            }
            .padding([.top, .bottom], 10)
        }
    }
}

#if DEBUG
struct TrackItemView_Previews : PreviewProvider {
    static var previews: some View {
        TrackItemView()
    }
}
#endif
