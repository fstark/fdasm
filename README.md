# fdasm
Fred's disassembler

# BUGS

- [Data] Sync of the "Data Window" with the disassembly view is not working properly
- [Code] Disassembly should not attempt to scroll to address out of ROM (may display it differently to start with)
- [Adrs] CMD_F (for instance) does not appear in the window (but should as it is referenced from df54)
- [Code] Jumping to an address from a duplicated window moves the main window
- [Code] Scroll at the end is weird sometimes (flashes back and forth)

# TODO

- decide on a f'cking color scheme
    - Addresses
        - Labels (none vs global vs local)
        - Code vs data
        - in ROM vs out of ROM
            color_for_address( address )
            => returns color
    - Bytes
    - Mnemonics
        - Operands
    - Comments
        - Adrs comments
        - System comments
        - Label comments
    - Information (like region type)
- Preferences Panel [IN PROGRESS]
- Labels window
    - Create new label [DONE]
    - Delete label
    - Edit comments from labels window
- Bookmarks
- Data display modes
- Data filter (search for bytes/words)
- Autoscroll to address when duplicating a panel [DONE]
- Make silent labels
- Make code a data panel at an address [DONE]
- History in data panels [DONE]
- Scroll to line should have a 5 lines gap [DONE]
- Xrefs from code located in data sections should be less trusted than xrefs from code sections [DONE]
- Cleanup
    - Style
        - public before private [DONE]
        - no direct access to members from outside the implementation
        - remove most header inline code [IN PROGRESS]
        - snake_case methods [DONE]
    - Changes
        - Regions/Labels/Annotations. Make a decision on names
        - Annotation's all_labels_ and labels_map_: wtf? [DONE]
        - Label * should be removed and use only names? [DONE] (mostly?)


- Section inspector
    - Change section name
    - Change section type (instr, data bytes, words, strings, etc)
        => regenerate disassembly
- Design the user interaction model
    - Tooltips ?
    - Inspectors (update on click, cannot close, open at startup) [DONE]
    - Separated windows (on double-click or via dup in inspectors) [DONE]
- Create some sort of Document object that gather everything together [DONE]
    - ROM
    - Labels
    - Disassembler
- Split the UI code in bits [IN PROGRESS]
- Make the windows specific classes and wrap the ImGUI init elsewhere [IN PROGRESS]
- Implement info panels for [DONE]
    - Bytes
    - Addresses
- Add comment
    - User comments [DONE]
    - Way to display "system" comments (user comments from target address)
- Labels
    - Think about local labels (have name but are only valid between 2 global labels)
- View modifiers
    - Display bytes in hex/ASCII (press 'A' to temp display?) [DONE]
    - Show/hide bytes column
    - Show/hide system comments
    - Show/hide addresses/labels
- Collapse/expand sections
    Sections are defined by global labels
- Think about an auto-labelling feature
    - Label all addresses that are referenced by a jump/call [DONE]
- Think about a section status
    (to track progress on the reverse engineering)
    (stuff could be collapsed by default depending no the status)
    (or maybe just make the collapse state persistent)

# UI Concepts

Some elements are displayed/interacted with in a consistent way across the UI:
- Bytes
    As hex
    As ASCII
    3 contexts:
    - As DB values
    - As operands
    - As data views
    When we display a byte, we know the address to be able to do some more context-aware stuff (like disassebling the operands)
    DisplayByte( byte, address, DisplayStyle, InteractionStyle )
        With DisplayStyle ==
            (h)ex, (d)ec, (o)ct, (a)scii, (b)inary (comes from the "region", but can be forced by modifier keys)
        With InteractionStyle ==
            Tooltip+Inspect+Open

- Addresses
    As hex
    As label
    As nearest label+displacement
    (Decorate with number of references?)
    (Decorate with comment from target address?)

    DisplayAddress( address, DisplayStyle, InteractionStyle );

- Comments
    ?

Data view:
    There is a data view that allows to explore the ROM
    It does not provide disassembly
    Modes:
    * Bytes (16 per line)
        - Octal, Decimal, Hexadecimal, Ascii (16 per line)
    * Words (8 per line or 4 with odd/even view)
    * Binary (4 per line)
    * Graphic
        - from 8 bits per line (1 byte)
        - to 256 bits per line (32 bytes)
    Commands:
        Arrow for navigation per byte or per line
    A toolbar with all the modes
    A direct entry of an address (or label)

