#!/bin/bash
# Script to install latest versions of VSCode extensions on Kali Linux

# List of extensions
extensions=(
    aaron-bond.better-comments
    almenon.arepl
    anthropic.claude-code
    aykutsarac.jsoncrack-vscode
    batisteo.vscode-django
    be5invis.vscode-custom-css
    chandan-sharma.csv-reader
    christian-kohler.npm-intellisense
    cocopon.iceberg-theme
    continue.continue
    davidbwaters.macos-modern-theme
    donjayamanne.python-environment-manager
    donjayamanne.python-extension-pack
    eamodio.gitlens
    esbenp.prettier-vscode
    github.copilot
    github.copilot-chat
    ivanarjona.cloudflaretunnel
    johnpapa.vscode-peacock
    kevinrose.vsc-python-indent
    mechatroner.rainbow-csv
    mindaro-dev.file-downloader
    ms-azuretools.vscode-containers
    ms-azuretools.vscode-docker
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    ms-python.vscode-python-envs
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.remote-explorer
    ms-vscode.remote-server
    mtxr.sqltools
    njpwerner.autodocstring
    oderwat.indent-rainbow
    pkief.material-icon-theme
    postman.postman-for-vscode
    quicktype.quicktype
    redhat.vscode-yaml
    shalldie.background
    silofy.hackthebox
    tht13.python
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    wholroyd.jinja
    wolfieshorizon.python-auto-venv
)

# Check if 'code' command is available
if ! command -v code &> /dev/null; then
    echo "Error: 'code' command not found. Open VSCode, press Ctrl+Shift+P,"
    echo "and run: Shell Command: Install 'code' command in PATH"
    exit 1
fi

echo "🚀 Installing VSCode extensions..."
for ext in "${extensions[@]}"; do
    echo "👉 Installing $ext ..."
    code --install-extension "$ext" --force
done

echo "✅ All extensions installed successfully!"
