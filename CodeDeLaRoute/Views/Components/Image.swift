//
//  Image.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 20/04/2022.
//

import SwiftUI
import SVGKit

extension SVGKImage {

    // MARK:- Private Method(s)
    private func fillColorForSubLayer(layer: CALayer, color: Color, opacity: Float) {
        if layer is CAShapeLayer {
            let shapeLayer = layer as! CAShapeLayer
            shapeLayer.fillColor = color.cgColor
            shapeLayer.opacity = opacity
        }

        if let sublayers = layer.sublayers {
            for subLayer in sublayers {
                fillColorForSubLayer(layer: subLayer, color: color, opacity: opacity)
            }
        }
    }

    private func fillColorForOutter(layer: CALayer, color: Color, opacity: Float) {
        if let shapeLayer = layer.sublayers?.first as? CAShapeLayer {
            shapeLayer.fillColor = color.cgColor
            shapeLayer.opacity = opacity
        }
    }

    // MARK:- Public Method(s)
    func fillColor(color: Color, opacity: Float) {
        if let layer = caLayerTree {
            fillColorForSubLayer(layer: layer, color: color, opacity: opacity)
        }
    }

    func fillOutterLayerColor(color: Color, opacity: Float) {
        if let layer = caLayerTree {
            fillColorForOutter(layer: layer, color: color, opacity: opacity)
        }
    }
}

struct SVGKFastImageViewSUI:UIViewRepresentable
{
    @Binding var url:URL
    @Binding var size:CGSize
    @Binding var tintColor: Color
    
    func makeUIView(context: Context) -> SVGKFastImageView {
       
       // let url = url
      //  let data = try? Data(contentsOf: url)
        let svgImage = SVGKImage(contentsOf: url)
        return SVGKFastImageView(svgkImage: svgImage ?? SVGKImage())
        
    }
    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        uiView.image = SVGKImage(contentsOf: url)
        
        uiView.image.size = size
        
        uiView.image.fillColor(color: tintColor, opacity: 1)
    }
    
    
}
