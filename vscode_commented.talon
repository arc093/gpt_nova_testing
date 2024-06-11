#custom vscode commands go here
app: vscode
-
window reload: user.vscode("workbench.action.reloadWindow") #reload the vscode interface
window close: user.vscode("workbench.action.closeWindow") #close the window in the vscode interface
#multiple_cursor.py support end

please [<user.text>]:
    user.vscode("workbench.action.showCommands")
    insert(user.text or "") #finds vscode commands that can be used

go view [<user.text>]:
    user.vscode("workbench.action.openView")
    insert(user.text or "") #open the view in the vscode interface

# Sidebar
#opens the file explorer section of the side panel/bar which allows the user to browse the file tree of the current project
bar explore: user.vscode("workbench.view.explorer") #opens the side panel file explorer bar
bar extensions: user.vscode("workbench.view.extensions") #opens the side panel extension store and manager
bar outline: user.vscode("outline.focus") #opens the side panel outline section
bar run: user.vscode("workbench.view.debug") #opens the sidebar run section
bar search: user.vscode("workbench.view.search") #opens the sidebar search/find section
bar source: user.vscode("workbench.view.scm") #opens the sidebar git management source manager
bar test: user.vscode("workbench.view.testing.focus") #open the sidebar testing window
bar switch: user.vscode("workbench.action.toggleSidebarVisibility") #toggle the sidebar visibility

# Symbol search
symbol hunt [<user.text>]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    insert(text or "") #search for vscode symbols

symbol hunt all [<user.text>]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    insert(text or "") #show all of the symbols for the search term in vscode

# Panels
panel control: user.vscode("workbench.panel.repl.view.focus") #switch to the control panel
panel output: user.vscode("workbench.panel.output.focus") #switch to the output section panel
panel problems: user.vscode("workbench.panel.markers.view.focus") #switch to the problems panel
panel switch: user.vscode("workbench.action.togglePanel") #toggles the bottom panel in vscode
panel terminal: user.vscode("workbench.action.terminal.focus") #switch to the terminal panel
focus editor: user.vscode("workbench.action.focusActiveEditorGroup") #open the editor for focus in vscode.

# Settings
show settings: user.vscode("workbench.action.openGlobalSettings") #open the main vscode settings window
show settings json: user.vscode("workbench.action.openSettingsJson") #open the json settings
show settings folder: user.vscode("workbench.action.openFolderSettings") #open the folder settings
show settings folder json: user.vscode("workbench.action.openFolderSettingsFile") #show the json settings file
show settings workspace: user.vscode("workbench.action.openWorkspaceSettings") #show the workspace settings
show settings workspace json: user.vscode("workbench.action.openWorkspaceSettingsFile") #show the json workspace settings
show shortcuts: user.vscode("workbench.action.openGlobalKeybindings") #show the shortcuts settings
show shortcuts json: user.vscode("workbench.action.openGlobalKeybindingsFile") #show the shortcuts jsons settings
show snippets: user.vscode("workbench.action.openSnippets") #show the vscode code snippets settings

# VSCode Snippets
snip (last | previous): user.vscode("jumpToPrevSnippetPlaceholder") #insert a snippet
snip next: user.vscode("jumpToNextSnippetPlaceholder") #insert the next vscode snippet

# Display
centered switch: user.vscode("workbench.action.toggleCenteredLayout") #toggle the center layout in vscode
fullscreen switch: user.vscode("workbench.action.toggleFullScreen") #switch to fullscreen mode
theme switch: user.vscode("workbench.action.selectTheme") #change the theme in vscode
wrap switch: user.vscode("editor.action.toggleWordWrap") #toggle the word wrap in vscode
zen switch: user.vscode("workbench.action.toggleZenMode") #toggle the vscode zen mode

# File Commands
file hunt [<user.text>]:
    user.vscode("workbench.action.quickOpen")
    sleep(50ms)
    insert(text or "") #search for a file in the side panel
file hunt (pace | paste):
    user.vscode("workbench.action.quickOpen")
    sleep(50ms)
    edit.paste() #search for a file in the side panel using the last used item on the clipboard
file copy name: user.vscode("fileutils.copyFileName") #copy the name of the file to the clipboard
file copy path: user.vscode("copyFilePath") #copy the file path to the clipboard
file copy local [path]: user.vscode("copyRelativeFilePath") #copy the relative local file path to clipboard
file create sibling: user.vscode_and_wait("explorer.newFile") #duplicate this file
file create: user.vscode("workbench.action.files.newUntitledFile") #create a new untitled file
file create relative: user.vscode("fileutils.newFile") #create a file in the relative directory
file create root: user.vscode("fileutils.newFileAtRoot") #create a file in the root directory
file rename: 
    user.vscode("fileutils.renameFile")
    sleep(150ms) #rename the current file
file move:
    user.vscode("fileutils.moveFile")
    sleep(150ms) #move the current file
file clone:
    user.vscode("fileutils.duplicateFile")
    sleep(150ms) #duplicate this file
file delete:
    user.vscode("fileutils.removeFile")
    sleep(150ms) #delete this file
file open folder: user.vscode("revealFileInOS") #open the file in the os
file reveal: user.vscode("workbench.files.action.showActiveFileInExplorer") #reveal the file in in the file explorer panel
save ugly: user.vscode("workbench.action.files.saveWithoutFormatting") #save the file without formatting

close other tabs: user.vscode("workbench.action.closeOtherEditors") #close all other tabs besides the current one
close all tabs: user.vscode("workbench.action.closeAllEditors") #close all tabs
close tabs way right: user.vscode("workbench.action.closeEditorsToTheRight") #close all the tabs to the right of the current one
close tabs way left: user.vscode("workbench.action.closeEditorsToTheLeft") #close all of the tabs to the left

# Folding
fold that: user.vscode("editor.fold") #fold this section so it's not visible
unfold that: user.vscode("editor.unfold") #unfold the section to make it visable again
fold all: user.vscode("editor.foldAll") #fold all of the sections
unfold all: user.vscode("editor.unfoldAll") #unfold all of the sections
fold comments: user.vscode("editor.foldAllBlockComments") #fold just the comments
fold one: user.vscode("editor.foldLevel1") #fold the first level
fold two: user.vscode("editor.foldLevel2") #fold the second level
fold three: user.vscode("editor.foldLevel3") #fold the third level
fold four: user.vscode("editor.foldLevel4") #fold the fourth level
fold five: user.vscode("editor.foldLevel5") #fold the fifth level
fold six: user.vscode("editor.foldLevel6") #fold the sixth level
fold seven: user.vscode("editor.foldLevel7") #fold the seventh level
