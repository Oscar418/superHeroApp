//
//  progressBar.swift
//  SuperHeros
//
//  Created by Oscar on 2020/11/23.
//

import UIKit
/// This is a class created for drawing graphs in Project
class progressBar: UIView {
    
    /**
         Call this function to draw a progress bar with a minimum of 0 and maximum of 100.
         - Parameters:
            - strokeColor : This is the color you would like your progress bar to have for foreground.
            - progress: Pass your CGFloat to determine how much progress you want displayed.
         
         ### Usage Example: ###
         ````
            progressBarView.progress = min(0.05 * self.countFired, self.progressValue)
         ````
         */
    
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    public var strokeCircleColor = UIColor.red.cgColor
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdate()
        }
    }

    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let lineWidth = 0.1 * min(width, height)
        backgroundLayer = createCicularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregroundLayer = createCicularLayer(rect: rect, strokeColor: strokeCircleColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        textLayer = createTextLayer(rect: rect, textColor: UIColor.white.cgColor)
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        layer.addSublayer(textLayer)
    }

}

extension progressBar {
    private func createCicularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let width = rect.width
        let height = rect.height
        let center = CGPoint(x: width/2, y: height/2)
        let radius = (min(width, height)) / 2
        let startAngle = -CGFloat.pi/2
        let endAngle = startAngle + 2 * CGFloat.pi
        let cicularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let shaperLayer = CAShapeLayer()
        shaperLayer.path = cicularPath.cgPath
        shaperLayer.strokeColor = strokeColor
        shaperLayer.fillColor = fillColor
        shaperLayer.lineWidth = lineWidth
        shaperLayer.lineCap = .round
        return shaperLayer
    }
    
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
        let width = rect.width
        let height = rect.height
        let fontSize = min(width, height)/4
        let offset = min(width, height)*0.1
        let layer = CATextLayer()
        layer.string = "\(Int(progress * 100))"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
        layer.alignmentMode = .center
        return layer
    }
    
    private func didProgressUpdate() {
        textLayer?.string = "\(Int(progress * 100))"
        foregroundLayer?.strokeEnd = progress
    }
}
