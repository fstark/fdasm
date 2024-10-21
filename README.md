# fdasm
Fred's disassembler

# TODO


- Create some sort of Document object that gather everything together [DONE]
    -> ROM
    -> Labels
    -> Disassembler
- Split the UI code in bits
- Make the windows specific classes and wrap the ImGUI init elsewhere
- Implement info panels for [DONE]
    - Bytes
    - Addresses
- Add comment
    - User comments
    - Way to display "system" comments (user comments from target address)
- Labels
    - Think about local labels (have name but are only valid between 2 global labels)
- View modifiers
    - Display bytes in hex/ASCII (press 'A' to temp display?) [DONE]
    - Show/hide bytes column
    - Show/hide system comments
- Collapse/expand sections
    Sections are defined by global labels
- Section inspector
    - Change section name
    - Change section type (instr, data bytes, words, strings, etc)
        => regenerate disassembly
- Think about an auto-labelling feature
    - Label all addresses that are referenced by a jump/call [DONE]
- Think about a section status
    (to track progress on the reverse engineering)
    (stuff could be collapsed by default depending no the status)
    (or maybe just make the collapse state persistent)
