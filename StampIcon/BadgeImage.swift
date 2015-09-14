//
//  BadgeImage.swift
//  StampIcon
//
//  Created by Jory Stiefel on 9/12/15.
//  Copyright © 2015 Jory Stiefel. All rights reserved.
//

import Cocoa

let kVerticalPadding: CGFloat = 3.0
let kHorizontalPadding: CGFloat = 7.0
let kMaxFontSize: CGFloat = 22.0
let π = CGFloat(M_PI)

struct StampConfig {
    var inputFile = ""
    var outputFile = ""
    var text = ""
    var textColor = NSColor.whiteColor()
    var badgeColor = NSColor(red: 0.98, green: 0.13, blue: 0.15, alpha: 1.0)
    var fontName = "Helvetica"
}

func generateBadgeImageWithConfig(config: StampConfig, maxWidth: CGFloat, maxHeight: CGFloat) -> NSImage {
    
    var textFontSize = kMaxFontSize
    var textFontAttributes = [
        NSFontAttributeName: NSFont(name: config.fontName, size: textFontSize)!,
        NSForegroundColorAttributeName: config.textColor
    ]
    
    let drawText = NSString(string: config.text)
    
    let badgeImage = NSImage(size: NSSize(width:maxWidth, height:maxHeight), flipped: false) { (rect) -> Bool in
        
        let context = NSGraphicsContext.currentContext()?.CGContext

        var textSize = drawText.sizeWithAttributes(textFontAttributes)
        while (textSize.width > maxWidth * 0.7) {
            textFontSize -= 0.25
            textFontAttributes[NSFontAttributeName] = NSFont(name: config.fontName, size: textFontSize)!
            textSize = drawText.sizeWithAttributes(textFontAttributes)
        }
        
        var badgeRect = rect.center(CGSize(width: maxWidth * 2, height: textSize.height + kVerticalPadding))

        badgeRect.origin.x += (1/6) * maxWidth
        badgeRect.origin.y -= (1/6) * maxHeight
        let textRect = badgeRect.center(textSize)
        
        CGContextTranslateCTM(context, badgeRect.center.x, badgeRect.center.y)
        CGContextRotateCTM(context, π / 4)
        CGContextTranslateCTM(context, -badgeRect.center.x, -badgeRect.center.y)
        
        config.badgeColor.setFill()
        NSRectFill(badgeRect)
        
        drawText.drawInRect(textRect, withAttributes: textFontAttributes)
        
        return true
    }
    
    return badgeImage;
}
