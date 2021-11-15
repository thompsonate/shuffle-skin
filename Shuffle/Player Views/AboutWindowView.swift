//
//  AboutWindowView.swift
//  shuffl
//
//  Created by Nate Thompson on 9/8/20.
//  Copyright © 2020 Nate Thompson. All rights reserved.
//

import SwiftUI

struct AboutWindowView: View {
    func getBundleInfo(forKey key: String) -> String {
        Bundle.main.infoDictionary?[key] as? String ?? ""
    }
    
    var versionString: String {
        "Version \(getBundleInfo(forKey: "CFBundleShortVersionString")) (\(getBundleInfo(forKey: "CFBundleVersion")))"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(nsImage: NSImage(imageLiteralResourceName:
                getBundleInfo(forKey: "CFBundleIconName")))
                .resizable()
                .frame(width: 64, height: 64)
            
            Text(getBundleInfo(forKey: "CFBundleName"))
                .font(.system(size: 14))
                .bold()
            
            Text(versionString)
                .font(.system(size: 10))
            
            Text(getBundleInfo(forKey: "NSHumanReadableCopyright"))
                .font(.system(size: 10))
        }
        .padding()
    }
}

struct AboutWindowView_Previews: PreviewProvider {
    static var previews: some View {
        AboutWindowView()
    }
}
