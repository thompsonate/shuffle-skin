//
//  Wedge.swift
//  Shuffle
//
//  Created by Nate Thompson on 2/16/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct Wedge: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        return path
    }
}

struct Wedge_Previews: PreviewProvider {
    static var previews: some View {
        Wedge(startAngle: .degrees(45), endAngle: .degrees(135))
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
