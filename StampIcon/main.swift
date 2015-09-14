//
//  main.swift
//  StampIcon
//
//  Created by Jory Stiefel on 9/12/15.
//  Copyright © 2015 Jory Stiefel. All rights reserved.
//

import Cocoa

func generateConfigFromArguments() -> StampConfig {
    
    var config = StampConfig()
    
    if Process.arguments.count == 1 {
        print("stampicon by Jory Stiefel")
        print("Usage: stampicon iconfile.png --text \"stamp text\" --output outputfile.png\n")
        exit(0)
    }

    for idx in 1..<Process.arguments.count {
        
        let argument = Process.arguments[idx]
        
        if idx == 1 {
            config.inputFile = argument
            continue
        }
        
        switch argument {
        case "--text":
            config.text = Process.arguments[idx+1]
            
        case "--output":
            config.outputFile = Process.arguments[idx+1]
            
        case "--font":
            config.fontName = Process.arguments[idx+1]
            
        case "--textcolor":
            config.textColor = NSColor(rgba: Process.arguments[idx+1])
            
        case "--badgecolor":
            config.badgeColor = NSColor(rgba: Process.arguments[idx+1])
            
        default:
            continue
        }
    }
    
    return config
}

var config = generateConfigFromArguments()
let stamper = Stamper(config: config)
stamper.processStamp();




