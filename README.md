# fdasm
Fred's disassembler

# BUGS

- [Data] Sync of the "Data Window" with the disassembly view is not working properly (click on data adrs) [DONE]
- [Code] Disassembly should not attempt to scroll to address out of ROM (may display it differently to start with) [DONE]
- [Adrs] CMD_F (for instance) does not appear in the window (but should as it is referenced from df54) [DONE]
- [Code] Jumping to an address from a duplicated window moves the main window [LATER]
- [Code] Scroll at the end is weird sometimes (flashes back and forth). Horizontal scrollbar? [LATER]
- [Code] When forcing ASCII display, the non-ascii characters are not displayed [DONE]
- [Data] Duplicating window loses the current display mode [DONE]

# TODO

- [Data] Adrs selection when clicking on word view content [DONE]
- Selected line in Data view [DONE]
- Edit label from Adrs view header [DONE]
- Edit label from Data view adresses / bytes?
- Cleanup annotation styles (like remove unknown?) [DONE]

- symplify annotations and add hints at label + address level
- decide on a f'cking color scheme [DONE]
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
- Preferences Panel [DONE]
- Labels window [DONE]
    - Create new label [DONE]
    - Delete label [DONE]
    - Edit comments from labels window [DONE}]
- Bookmarks [LATER]
- Notes [LATER]
- Data display modes [DONE]
- Data filter (search for bytes/words) [LATER]
- Autoscroll to address when duplicating a panel [DONE]
- Make silent labels [LATER]
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


- Section inspector [DONE]
    - Change section name [DONE]
    - Change section type (instr, data bytes, words, strings, etc) [DONE]
        => regenerate disassembly [DONE]
- Design the user interaction model [DONE]
    - Tooltips ? [DONE]
    - Inspectors (update on click, cannot close, open at startup) [DONE]
    - Separated windows (on double-click or via dup in inspectors) [DONE]
- Create some sort of Document object that gather everything together [DONE]
    - ROM
    - Labels
    - Disassembler
- Split the UI code in bits [DONE]
- Make the windows specific classes and wrap the ImGUI init elsewhere [IN PROGRESS]
- Implement info panels for [DONE]
    - Bytes
    - Addresses
- Add comment [DONE]
    - User comments [DONE]
    - Way to display "system" comments (user comments from target address) [LATER]
- Labels [LATER]
    - Think about local labels (have name but are only valid between 2 global labels)
- View modifiers
    - Display bytes in hex/ASCII (press 'A' to temp display?) [DONE]
    - Show/hide bytes column [LATER]
    - Show/hide system comments [LATER]
    - Show/hide addresses/labels [LATER]
- Collapse/expand sections [LATER]
    Sections are defined by global labels
- Think about an auto-labelling feature [DONE]
    - Label all addresses that are referenced by a jump/call [DONE]
- Think about a section status [LATER]
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

Data view:
    There is a data view that allows to explore the ROM
    It does not provide disassembly
    Modes:
    * Bytes (16 per line) [DONE]
        - Octal, Decimal, Hexadecimal, Ascii (16 per line) [LATER]
    * Words (8 per line or 4 with odd/even view) [DONE]
    * Binary (4 per line)
    * Graphic
        - from 8 bits per line (1 byte) [DONE]
        - to 256 bits per line (32 bytes) [LATER]
    Commands:
        Arrow for navigation per byte or per line [LATER]
    A toolbar with all the modes
    A direct entry of an address (or label) [LATER]

