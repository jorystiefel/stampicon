# stampicon
Applies a text label to PNG icons. Stampicon will automatically size the text to fit inside the ribbon, but exceedingly long text on small icons may become unreadable.

### Usage

`stampicon inputfile.png --output outputfile.png --text "text to overlay"`

option        | meaning
--------------|--------------------
--text        | the text to overlay, required
--output      | the file to write, required
--font        | font family, e.g, defaults to "Helvetica"
--textcolor   | the text hex color in hex #FFFFFF, defaults to white
--badgecolor  | the hex color of the ribbon behind the text, defaults to red


