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
    private var mode =  Doing.drawField
    private var numOfPaintingZone = 0
    private var pointOfTapped = CGPoint()
    
    enum Doing
    {
        case drawField
        case paintZone
    }
    
    override func draw(_ rect: CGRect)
    {
        //self.clearsContextBeforeDrawing = true
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
        setNeedsDisplay()
    }
    
    private func paintZone(context:  CGContext)
    {
        for i in 0...zones.count-1
        {
            zones[i].tapped = false
            context.addPath(zones[i].path)
            if zones[i].path.contains(pointOfTapped)
            {
                
                if numOfPaintingZone != i+1
                {
                    print("WAS SELECTED \(i+1)-TH ZONE")
                    numOfPaintingZone = i+1
                    zones[i].tapped = true
                    
                }
                else
                {
                    print("WAS DESELECTED \(i+1)-TH ZONE")
                    numOfPaintingZone = 0
                }
            }
            zones[i].tapped ? (context.setFillColor(UIColor.red.cgColor)) : (context.setFillColor(zones[i].color))
            context.fillPath()
            context.addPath(zones[i].path)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(5)
            context.strokePath()
            
        }
        
        
    }
    
    private func paintCurrentPath(context: CGContext, color: UIColor)
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
        
        let centerPoint = CGPoint(x: bounds.width / 2, y: 0)
        let colors = [UIColor(red: 255/255, green: 168/255, blue: 89/255, alpha: 1), UIColor(red: 255/255, green: 217/255, blue: 179/255, alpha: 1), UIColor(red: 253/255, green: 197/255, blue: 146/255, alpha: 1)]
        
        let radius = bounds.width / 8
        
        // 1 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: 0, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: radius, y: 0))
        paintCurrentPath(context: context, color: colors[0])
        
        //2 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(150).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: 0, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: 0, y: bounds.height ))
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(150).degreesToRadians, clockwise: false)
        paintCurrentPath(context: context, color: colors[2])
        // 3 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: false)
        paintCurrentPath(context: context, color: colors[0])
        // 4 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: bounds.width, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: bounds.width ,y: bounds.height))
        context.addArc(center: centerPoint, radius: 5 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[2])
        // 5 zone
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(30).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: true)
        context.addLine(to: CGPoint(x: bounds.width, y: context.currentPointOfPath.y))
        context.addLine(to: CGPoint(x: bounds.width, y: 0))
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(30).degreesToRadians, clockwise: false)
        paintCurrentPath(context: context, color: colors[0])
        // 6 zone
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(45).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(45).degreesToRadians, endAngle: CGFloat(45).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(45).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[1])
        // 7 zone
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(45).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(45).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(45).degreesToRadians, endAngle: CGFloat(45).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[0])
        // 8 zone
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(75).degreesToRadians, endAngle: CGFloat(75).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[2])
        // 9 zone
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(135).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(135).degreesToRadians, endAngle: CGFloat(135).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(135).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(105).degreesToRadians, endAngle: CGFloat(105).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[0])
        // 10 zone
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(135).degreesToRadians, endAngle: CGFloat(180).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(180).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 3 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(135).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(135).degreesToRadians, endAngle: CGFloat(135).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[1])
        
        
        // 11 zone
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(120).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(120).degreesToRadians, endAngle: CGFloat(120).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(120).degreesToRadians, endAngle: CGFloat(180).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(180).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[2])
        // 12 zone
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(120).degreesToRadians, endAngle: CGFloat(60).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(60).degreesToRadians, endAngle: CGFloat(60).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(60).degreesToRadians, endAngle: CGFloat(120).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(120).degreesToRadians, endAngle: CGFloat(120).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[1])
        // 13 zone
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(60).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 2 * radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(60).degreesToRadians, clockwise: false)
        context.addArc(center: centerPoint, radius: 1 * radius, startAngle: CGFloat(60).degreesToRadians, endAngle: CGFloat(60).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[2])
        // 14 zone
        context.addArc(center: centerPoint, radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        paintCurrentPath(context: context, color: colors[0])
    }
    
   private func drawLabelFields()
    {
        let xInset: CGFloat = 25
        let yInset: CGFloat = 10
        // need change 1, 3, 5
        for i in 0...zones.count-1
        {
            var point = CGPoint()
//            switch i {
//            case 0:
//                point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX - zones[i].path.boundingBoxOfPath.width / 3, y: zones[i].path.boundingBoxOfPath.midY - yInset)
//                break
//            case 2:
//                point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX - xInset, y: zones[i].path.boundingBoxOfPath.midY - zones[i].path.boundingBoxOfPath.height / 3)
//                break
//            case 4:
//                point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX - xInset / 2, y: zones[i].path.boundingBoxOfPath.midY - yInset)
//                break
//            default:
//                point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX - xInset, y: zones[i].path.boundingBoxOfPath.midY - yInset)
//            }
//            if i == 0 || i == 2 || i == 4
//            {
//                point =
//            }
//            else
                
//            point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX - 25, y: zones[i].path.boundingBoxOfPath.midY - 10)
            
            point = CGPoint(x: zones[i].path.boundingBoxOfPath.midX, y: zones[i].path.boundingBoxOfPath.midY)
            let labelView = UILabel()
            labelView.center = point
            labelView.frame.size = CGSize(width: self.frame.width / 10, height: self.frame.height / 10)
//            labelView.numberOfLines = 2
            labelView.text = "10/45\n100%"
            labelView.textAlignment = .center
            self.addSubview(labelView)
        }
    }
}
