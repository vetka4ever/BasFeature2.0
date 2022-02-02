//
//  Field.swift
//  BasketApp2.0
//
//  Created by Daniil on 15.12.2021.
//

import UIKit

struct Zone
{
    var path: CGPath
    var color: CGColor
    var tapped: Bool
}

extension CGFloat
{
    var degreesToRadians: Self { return self * .pi / 180}
}

class Field: UIView
{
    private var zones: [Zone] = [Zone]()
    private var textLabels = [UILabel]()
    private var mode =  Doing.drawField
    private var numOfPaintedZone = 0
    private var pointOfTapped = CGPoint()
    private var radius: CGFloat = 0
    private var centerPoint = CGPoint(x: 0, y: 0)
    
    enum Doing
    {
        case drawField
        case paintZone
    }
    
    override func draw(_ rect: CGRect)
    {
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        switch (mode)
        {
        case .drawField:
            mode = .paintZone
            self.layer.borderWidth = 5
            self.layer.borderColor = UIColor.black.cgColor
            drawField(context: context)
            drawLabelFields()
            break
        case .paintZone:
            paintZone(context: context)
            break
        }
    }
    
    func paintZoneByTap(point: CGPoint)
    {
        self.pointOfTapped = point
        var numOfSelectedZone = 0
        if numOfPaintedZone != 0
        {zones[numOfPaintedZone - 1].tapped = false}
        for i in 0...zones.count-1
        {
            if zones[i].path.contains(point) && i+1 != numOfPaintedZone
            {
                zones[i].tapped = true
                numOfSelectedZone = i+1
            }
        }
        
        self.numOfPaintedZone = numOfSelectedZone
        print("SELECTED \(numOfPaintedZone)-th ZONE")
        setNeedsDisplay()
        
    }
    
    func turnLabels(on: Bool)
    {
        for item in textLabels
        {
            item.isHidden = !on
        }
    }
    
    func getNumOfPaintedZone() -> Int
    {
        return self.numOfPaintedZone
    }
    
    private func paintZone(context:  CGContext)
    {
        for i in 0...zones.count-1
        {
            
            context.addPath(zones[i].path)
            zones[i].tapped ? (context.setFillColor(UIColor.red.cgColor)) : (context.setFillColor(zones[i].color))
            context.fillPath()
            context.addPath(zones[i].path)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(5)
            context.strokePath()
            
        }
        
    }
    
    private func fillCurrentPath(context: CGContext, color: UIColor)
    {
        let path = context.path
        if zones.count < 14 {zones.append(Zone(path: path!, color: color.cgColor, tapped: false))}
        
        context.setFillColor(color.cgColor)
        context.fillPath()
        
        context.addPath(path!)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(5)
        context.strokePath()
        
    }
    private func drawField(context: CGContext)
    {
        
        centerPoint = CGPoint(x: bounds.width / 2, y: 0)
        let colors = [UIColor(red: 255/255, green: 168/255, blue: 89/255, alpha: 1),
                      UIColor(red: 255/255, green: 217/255, blue: 179/255, alpha: 1),
                      UIColor(red: 253/255, green: 197/255, blue: 146/255, alpha: 1)]
        radius = bounds.width / 8
        
        let corners: [[CGFloat]] = [[180, 120, 60, 0], [180, 135, 105, 75, 45, 0], [105, 75]]
        // 1 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: 0, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: radius, y: 0))
        fillCurrentPath(context: context, color: colors[0])
        
        //2 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(150).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: 0, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: 0, y: bounds.height ))
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: false)
        fillCurrentPath(context: context, color: colors[2])
        // 3 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: false)

        fillCurrentPath(context: context, color: colors[0])
        // 4 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: bounds.width, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: bounds.width ,y: bounds.height))
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        fillCurrentPath(context: context, color: colors[2])
        // 5 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(30).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: bounds.width, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: bounds.width, y: 0))
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: false)
        fillCurrentPath(context: context, color: colors[0])
        

        // 6-13 zones
        // [([CGFloat], CGFloat, [Int])] - ([corners for every group of zones], keyForRadius, [numbers of colors of zones in array])
        let data3: [([CGFloat], CGFloat, [Int])] = [([180, 135, 105, 75, 45, 0], 2, [1,0,2,0,1]), ([180, 120, 60, 0], 1, [2,1,2])]
        for item in data3
        {
            for i in 1...item.0.count-1
            {
                paintArcZone(context: context, startAngle: item.0[i-1], endAngle: item.0[i], keyForRadius: item.1)
                fillCurrentPath(context: context, color: colors[item.2[i-1]])
            }
        }
        // 14 zone
        context.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        fillCurrentPath(context: context, color: colors[0])
    }
    
//     drawing by left and up to right
    private func paintArcZone(context: CGContext, startAngle: CGFloat, endAngle: CGFloat, keyForRadius: CGFloat)
    {
        context.addArc(center: centerPoint, radius: keyForRadius * radius, startAngle: CGFloat(startAngle).degreesToRadians, endAngle: CGFloat(endAngle).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: (keyForRadius + 1) * radius, startAngle: CGFloat(endAngle).degreesToRadians, endAngle: CGFloat(endAngle).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: (keyForRadius + 1) * radius, startAngle: CGFloat(endAngle).degreesToRadians, endAngle: CGFloat(startAngle).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: keyForRadius * radius, startAngle: CGFloat(startAngle).degreesToRadians, endAngle: CGFloat(startAngle).degreesToRadians, clockwise: true)
    }
    private func drawLabelFields()
    {
        let xInset: CGFloat = 25
        let yInset: CGFloat = 10
        var point = CGPoint()
        for i in 0...zones.count-1
        {
            point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX, y: zones[i].path.boundingBoxOfPath.midY)
            let labelView = UILabel()
            labelView.center = point
            labelView.frame.size = CGSize(width: self.frame.width / 10, height: self.frame.height / 10)
            
            labelView.text = "10/45\n100%"
            labelView.textAlignment = .center
            textLabels.append(labelView)
            labelView.isHidden = true
            self.addSubview(labelView)
        }
    }
}
