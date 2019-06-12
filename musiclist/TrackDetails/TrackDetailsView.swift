//
//  TrackDetailsView.swift
//  musiclist
//
//  Created by Artem Shuba on 11/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import SwiftUI

struct TrackDetailsView : View {
    let viewModel: TrackDetailsViewModel
    
    init(track: Track) {
        self.viewModel = TrackDetailsViewModel(track: track)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (alignment: .leading) {
                    TrackHeaderView(track: self.viewModel.track)
                    Spacer(minLength: 20)
                    
                    Text("OVERVIEW")
                        .font(.headline)
                    Spacer(minLength: 10)
                    
                    Text(self.viewModel.description ?? "")
                        .lineLimit(nil)
                }
                .padding(20)
                // Workaround to fix sizing issues of ScrollView in Beta 1
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }.navigationBarTitle(Text("Details"), displayMode: .inline)
    }
}

#if DEBUG
struct TrackDetailsView_Previews : PreviewProvider {
    static var previews: some View {
        TrackDetailsView()
    }
}
#endif
