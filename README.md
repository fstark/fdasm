# fdasm
Fred's disassembler

# Build

use ``git clone --recurse-submodules <repository_url>`` to checkout the imgui dependency

# Usage

fdasm --rom SOMETHING.bin --fda SOMETHING.fda --asm SOMETHING.asm

This will start a UI for disassembling SOMETHING.BIN. The disassembly data ("the project?") will be stored in the ``fda`` file. SOMETHING.ASM will contains a text assembly version (much less complete than the one in the UI for now). 

# Overview

This is a powerful graphical user interface to reverse-engineer a 8085 ROM.

Using the tool, you can:

* Create named regions (labels) with their own comments and decompilation style (assembly, DB, DW, strings, etc)
* Associate each label with a comment
* Annotate each address with a potential comment

This will produce a readable assembly listing that can be used to understand the ROM content.

To perform the work, the following features are available:

* Always up-to-date disassembly view
    The central disassembly view is always up-to-date and guaranteed to produce exactly the ROM content.

* Initial label discovery
    When opening a ROM for the first time, ``fdasm`` will create labels for all addresses that are referenced by assembly instruction. It will type the labels as code for addresses generated by jumps or calls, and as bytes for addresses generated by LDA, STA or LXI instructions.

* Immediate feedback
    All tools are designed to provide immediate feedback. For instance, hovering over an address will highligh it in all the views. Deleting a label automatically update all the related views. Hovering over a call will preview the target code.

* Powerful navigation features
    Clicking on a jump target let you navigate in the disassembly view. There are tools to explore memory, navigate through label, view cross-references, etc...

* Multiple windows
    Any window can be duplicated so it is possible to work on several part of the rom at the same time. The disassembly is editable via all views.

* Embedded documentation
    8085 documentation is embedded and will be displayed when hovering over an instruction.

# Main windows

## Disassembly view

This is the main window. It displays the current disassembly of the ROM. It is always up-to-date and guaranteed to be the exact content of the ROM.

For each line, it shows the addresses, the bytes, the mnemonics and operands, and the comments.
In addition it shows the labels and the related comments.
Pressing 'a' will force the display of the bytes as ASCII characters. Pressing 'l' will force the display of addresses as labels and vice-versa.

In this view, you can:
* Create/delete and edit labels for any address of the ROM
* Create/delete and edit comments
* Navigate in the code

## Label view

This view displays all the labels. It allows you to search and navigate to specific labels.

In this view, you can:
* Create/delete and edit labels even for addresses which are not in the ROM
* Create/delete and edit comments
* Find labels

## Address view

This view displays the last clicked address and all cross references to it. The cross-references shows the instruction that reference the address, to distinguish from jumps, call, data load, or just plain data.

In this view, you can:
* Created/delete/edit a label for the address
* Hover a code cross-reference to preview the target code
* Navigate to the target code or data

## Data view

This view displays the content of the ROM in 3 different formats: as bytes, as words (little endian), or as a graphical view. Pressing 'a' will force the display of the bytes as ASCII characters. Pressing 'l' will force the display of addresses as labels.

In this view you can:
* Look a individual bytes
* Navigate to a specific address by clicking on it
* Look for a specific word in memory (addresses are hilightedin this view when hovering anywhere else)
* Look at the graphic pattern of the ROM (useful to find embeded character definitions)

## I/O Port List View

The I/O view regroups all the IO ports usages in order to help understand the I/O ports usage. Using this view, you can see what ports are used for reading and writing.

Selecting a port will show the instructions in the IO Port View

In this list you can:
* Navigate to the IO Port View

## IO Port View

The I/O Port View lets you assign a name to an I/O port and add a description to it. It also lists all the instructions that read and writes to this port.

In this view, youcan:

* Create/delete/edit a label for the port
* Create/delete/edit a comment for the port
* Navigate to the instructions that read/write to the port

## Byte view

This views displays the last selected byte, in different formats (hex, decimal, octal, binary, ASCII). It also includes the 8085 documentation for the instruction.

## Preferences

This view allows you to choose the colors for the syntax highlighting and other displays.






# BUGS


- [Code][Data] Cannot create label outside of begining of line
- [Disass] ~/Development/fdasm/fdasm --disass portal.bin => disassembles an extra line

- [Adrs] Look at BUFFER: line on each others [DONE]
- [Data] Sync of the "Data Window" with the disassembly view is not working properly (click on data adrs) [DONE]
- [Code] Disassembly should not attempt to scroll to address out of ROM (may display it differently to start with) [DONE]
- [Adrs] CMD_F (for instance) does not appear in the window (but should as it is referenced from df54) [DONE]
- [Code] Jumping to an address from a duplicated window moves the main window [LATER]
- [Code] Scroll at the end is weird sometimes (flashes back and forth). Horizontal scrollbar? [LATER]
- [Code] When forcing ASCII display, the non-ascii characters are not displayed [DONE]
- [Data] Duplicating window loses the current display mode [DONE]

# TODO

- [UI] Add icons to menu items
- [UI] Handle double-click
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

