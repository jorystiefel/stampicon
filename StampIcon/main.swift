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

    guard Process.arguments.count > 1 else {
        print("stampicon by Jory Stiefel")
        print("Usage: stampicon iconfile.png --text \"stamp text\" --output outputfile.png\n")
        exit(0)
    }

    for (idx, argument) in Process.arguments.dropFirst().enumerate() {
        guard idx > 0 else {
            config.inputFile = argument
            continue
        }
        
        let argIdx = idx + 1
        
        switch argument {
        case "--text":
            config.text = Process.arguments[argIdx+1]

        case "--output":
            config.outputFile = Process.arguments[argIdx+1]

        case "--font":
            config.fontName = Process.arguments[argIdx+1]

        case "--textcolor":
            config.textColor = NSColor(rgba: Process.arguments[argIdx+1])

        case "--badgecolor":
            config.badgeColor = NSColor(rgba: Process.arguments[argIdx+1])

        default:
            continue
        }

    }

    return config
}

var config = generateConfigFromArguments()
let stamper = Stamper(config: config)
stamper.processStamp()




