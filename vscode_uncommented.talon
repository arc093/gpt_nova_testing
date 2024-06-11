app: vscode
-
window reload: user.vscode("workbench.action.reloadWindow")
window close: user.vscode("workbench.action.closeWindow") 

please [<user.text>]:
    user.vscode("workbench.action.showCommands")
    insert(user.text or "") 

go view [<user.text>]:
    user.vscode("workbench.action.openView")
    insert(user.text or "") 

bar explore: user.vscode("workbench.view.explorer")
bar extensions: user.vscode("workbench.view.extensions")
bar outline: user.vscode("outline.focus")
bar run: user.vscode("workbench.view.debug")
bar search: user.vscode("workbench.view.search")
bar source: user.vscode("workbench.view.scm")
bar test: user.vscode("workbench.view.testing.focus")
bar switch: user.vscode("workbench.action.toggleSidebarVisibility")

symbol hunt [<user.text>]:
    user.vscode("workbench.action.gotoSymbol")
    sleep(50ms)
    insert(text or "")

symbol hunt all [<user.text>]:
    user.vscode("workbench.action.showAllSymbols")
    sleep(50ms)
    insert(text or "")

panel control: user.vscode("workbench.panel.repl.view.focus")
panel output: user.vscode("workbench.panel.output.focus")
panel problems: user.vscode("workbench.panel.markers.view.focus")
panel switch: user.vscode("workbench.action.togglePanel")
panel terminal: user.vscode("workbench.action.terminal.focus")
focus editor: user.vscode("workbench.action.focusActiveEditorGroup")

show settings: user.vscode("workbench.action.openGlobalSettings")
show settings json: user.vscode("workbench.action.openSettingsJson")
show settings folder: user.vscode("workbench.action.openFolderSettings")
show settings folder json: user.vscode("workbench.action.openFolderSettingsFile")
show settings workspace: user.vscode("workbench.action.openWorkspaceSettings")
show settings workspace json: user.vscode("workbench.action.openWorkspaceSettingsFile")
show shortcuts: user.vscode("workbench.action.openGlobalKeybindings")
show shortcuts json: user.vscode("workbench.action.openGlobalKeybindingsFile")
show snippets: user.vscode("workbench.action.openSnippets")

snip (last | previous): user.vscode("jumpToPrevSnippetPlaceholder")
snip next: user.vscode("jumpToNextSnippetPlaceholder")

centered switch: user.vscode("workbench.action.toggleCenteredLayout")
fullscreen switch: user.vscode("workbench.action.toggleFullScreen")
theme switch: user.vscode("workbench.action.selectTheme")
wrap switch: user.vscode("editor.action.toggleWordWrap")
zen switch: user.vscode("workbench.action.toggleZenMode")

file hunt [<user.text>]:
    user.vscode("workbench.action.quickOpen")
    sleep(50ms)
    insert(text or "")
file hunt (pace | paste):
    user.vscode("workbench.action.quickOpen")
    sleep(50ms)
    edit.paste()
file copy name: user.vscode("fileutils.copyFileName")
file copy path: user.vscode("copyFilePath")
file copy local [path]: user.vscode("copyRelativeFilePath")
file create sibling: user.vscode_and_wait("explorer.newFile")
file create: user.vscode("workbench.action.files.newUntitledFile")
file create relative: user.vscode("fileutils.newFile")
file create root: user.vscode("fileutils.newFileAtRoot")
file rename:
    user.vscode("fileutils.renameFile")
    sleep(150ms)
file move:
    user.vscode("fileutils.moveFile")
    sleep(150ms)
file clone:
    user.vscode("fileutils.duplicateFile")
    sleep(150ms)
file delete:
    user.vscode("fileutils.removeFile")
    sleep(150ms)
file open folder: user.vscode("revealFileInOS")
file reveal: user.vscode("workbench.files.action.showActiveFileInExplorer")
save ugly: user.vscode("workbench.action.files.saveWithoutFormatting")

close other tabs: user.vscode("workbench.action.closeOtherEditors")
close all tabs: user.vscode("workbench.action.closeAllEditors")
close tabs way right: user.vscode("workbench.action.closeEditorsToTheRight")
close tabs way left: user.vscode("workbench.action.closeEditorsToTheLeft")

fold that: user.vscode("editor.fold")
unfold that: user.vscode("editor.unfold")
fold all: user.vscode("editor.foldAll")
unfold all: user.vscode("editor.unfoldAll")
fold comments: user.vscode("editor.foldAllBlockComments")
fold one: user.vscode("editor.foldLevel1")
fold two: user.vscode("editor.foldLevel2")
fold three: user.vscode("editor.foldLevel3")
fold four: user.vscode("editor.foldLevel4")
fold five: user.vscode("editor.foldLevel5")
fold six: user.vscode("editor.foldLevel6")
fold seven: user.vscode("editor.foldLevel7")
