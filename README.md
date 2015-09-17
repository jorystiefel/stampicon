# stampicon
Applies a text label to PNG icons. Stampicon will automatically size the text to fit inside the ribbon, but exceedingly long text on small icons may become unreadable.

This tool differs from other similar tools in that it renders the icon using Core Graphics, rather than requiring a dependency such as ImageMagick.

![Before](https://github.com/jorystiefel/stampicon/blob/master/Demo/Icon-76.png)
![After](https://github.com/jorystiefel/stampicon/blob/master/Demo/Icon-76.1.png)

### Usage

`stampicon inputfile.png --output outputfile.png --text "text to overlay"`

option        | meaning
--------------|--------------------
--text        | the text to overlay, required
--output      | the file to write, required
--font        | font family, e.g, defaults to "Helvetica"
--textcolor   | the text hex color in hex #FFFFFF, defaults to white
--badgecolor  | the hex color of the ribbon behind the text, defaults to red

### Thanks

This utility employs [SwiftCGRectExtensions](https://github.com/nschum/SwiftCGRectExtensions) by @nschum and [UIColor-Hex-Swift](https://github.com/yeahdongcn/UIColor-Hex-Swift/blob/master/UIColorExtension.swift) by @yeahdongcn
