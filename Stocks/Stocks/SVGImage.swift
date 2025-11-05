//
//  SVGImage.swift
//  Stocks
//
//  Created by Harrinandhaan Sathish Kumaar Nirmala on 7/15/21.
//

import SwiftUI
import SVGKit

struct SVGLogo: UIViewRepresentable {
    
    var SVGUrl: String
        
    func makeUIView(context: Context) -> UIImageView {
        
        let svg = URL(string: SVGUrl)!
        let data = try? Data(contentsOf: svg)
        
        let imgViewObj = UIImageView()
        let logoSVG:SVGKImage = SVGKImage(data: data)
        
       
        imgViewObj.image = logoSVG.uiImage
        
        return imgViewObj
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
    
}

