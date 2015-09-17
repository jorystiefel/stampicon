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

struct Stamper {
    
    let config: StampConfig

    func generateBadgeImage(maxWidth: CGFloat, maxHeight: CGFloat) -> NSImage {
        
        var textFontSize = kMaxFontSize
        var textFontAttributes = [
            NSFontAttributeName: NSFont(name: config.fontName, size: textFontSize)!,
            NSForegroundColorAttributeName: config.textColor
        ]
        
        let drawText = config.text
        
        let badgeImage = NSImage(size: NSSize(width:maxWidth, height:maxHeight), flipped: false) { rect -> Bool in
            
            let context = NSGraphicsContext.currentContext()?.CGContext
            
            var textSize = drawText.sizeWithAttributes(textFontAttributes)
            while (textSize.width > maxWidth * 0.7) {
                textFontSize -= 0.25
                textFontAttributes[NSFontAttributeName] = NSFont(name: self.config.fontName, size: textFontSize)!
                textSize = drawText.sizeWithAttributes(textFontAttributes)
            }
            
            var badgeRect = rect.center(CGSize(width: maxWidth * 2, height: textSize.height + kVerticalPadding))
            
            badgeRect.origin.x += (1.0/6) * maxWidth
            badgeRect.origin.y -= (1.0/6) * maxHeight
            let textRect = badgeRect.center(textSize)
            
            CGContextTranslateCTM(context, badgeRect.center.x, badgeRect.center.y)
            CGContextRotateCTM(context, π / 4)
            CGContextTranslateCTM(context, -badgeRect.center.x, -badgeRect.center.y)
            
            self.config.badgeColor.setFill()
            NSRectFill(badgeRect)
            
            drawText.drawInRect(textRect, withAttributes: textFontAttributes)
            
            return true
        }
        
        return badgeImage
    }
    
    func generateOutputImage() -> NSImage? {
        guard let inputImage = NSImage(contentsOfFile: self.config.inputFile) else {
            print("Could not read input file")
            exit(-1)
        }

        let badgeImage = stamper.generateBadgeImage(inputImage.size.width, maxHeight: inputImage.size.height)

        let outputImage = NSImage(size: inputImage.size, flipped: false, drawingHandler: { (rect) -> Bool in
            inputImage.drawInRect(rect)
            badgeImage.drawInRect(rect)
            return true
        })

        return outputImage
    }

    func writeImageFile(image: NSImage, filename: String) {
        
        if let imageData = image.TIFFRepresentation,
            let pngRepresentation: NSData = NSBitmapImageRep(data: imageData)?.representationUsingType(.NSPNGFileType, properties: [:])
        {
            let success = pngRepresentation.writeToFile(filename, atomically: true)
            if !success {
                print("Error writing file")
                exit(-1)
            }
        }
    }
    
    func processStamp() {
        
        if let outputImage = self.generateOutputImage() {
            writeImageFile(outputImage, filename: config.outputFile)
        } else {
            print("Could not generate output image")
        }
    }
    
}
