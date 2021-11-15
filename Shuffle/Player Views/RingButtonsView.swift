//
//  RingButtonsView.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/16/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct RingButtonsView: View {
    @EnvironmentObject var shuffle: ShuffleManager
    
    var body: some View {
        ZStack {
            RingButton(startAngle: .degrees(45), endAngle: .degrees(135)) {
                print("volume down")
            }
                .environmentObject(self.shuffle)

            RingButton(startAngle: .degrees(135), endAngle: .degrees(225)) {
                print("previous track")
            }
                .environmentObject(self.shuffle)

            RingButton(startAngle: .degrees(225), endAngle: .degrees(315)) {
                print("volume up")
            }
                .environmentObject(self.shuffle)
            
            RingButton(startAngle: .degrees(315), endAngle: .degrees(45)) {
                print("next track")
            }
                .environmentObject(self.shuffle)
        }
    }
}


struct RingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RingButtonsView().environmentObject(ShuffleManager.shared)
    }
}
