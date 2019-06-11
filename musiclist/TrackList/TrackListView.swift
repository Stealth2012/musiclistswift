//
//  TrackListView.swift
//  musiclist
//
//  Created by Artem Shuba on 07/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import SwiftUI

struct TrackListView : View {
    @EnvironmentObject var viewModel: TrackListViewModel

    var body: some View {
        return NavigationView {
            List {
                ForEach(viewModel.tracks) { track in
                    NavigationButton(destination: TrackDetailsView()) {
                        TrackItemView(track: track)
                    }
                }
            }
            .navigationBarTitle(Text("Songs"))
        }
    }
}

#if DEBUG
struct TrackListView_Previews : PreviewProvider {
    static var previews: some View {
        TrackListView()
    }
}
#endif
