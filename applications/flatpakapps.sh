flatpak_apps=(
    org.zaproxy.ZAP
    # io.github.mimbrero.WhatsAppDesktop
    # org.gnome.Boxes
    io.podman_desktop.PodmanDesktop
    com.github.tchx84.Flatseal
    io.github.flattool.Warehouse
    org.gnome.Logs
    org.gnome.font-viewer
    # net.nokyan.Resources
    # org.gnome.Shotwell
    # org.gnome.eog
    # org.gnome.Loupe
    # com.github.xournalpp.xournalpp
    # io.beekeeperstudio.Studio
    # ca.desrt.dconf-editor
    # org.blender.Blender
    com.obsproject.Studio
    # org.gimp.GIMP
    # org.filezillaproject.Filezilla
    # io.github.shiftey.Desktop
    # org.gnome.baobab
    # org.gnome.Epiphany
    # org.gimp.GIMP.Plugin.GMic
    # org.gimp.GIMP.Plugin.Resynthesizer
    # org.gimp.GIMP.Plugin.LiquidRescale
    # org.gimp.GIMP.Plugin.Lensfun org.gimp.GIMP.Plugin.GMic
    # org.gimp.GIMP.Plugin.Fourier org.gimp.GIMP.Plugin.FocusBlur
    # org.gimp.GIMP.Plugin.BIMP
    # com.spotify.Client
    # com.discordapp.Discord
    com.signal.Signal-Desktop
    com.getpostman.Postman
    org.telegram.desktop
    # com.brave.Browser
    io.github.zen_browser.zen
    com.todoist.Todoist
    # com.google.AndroidStudio
    com.bitwarden.desktop
    md.obsidian.Obsidian
    org.angryip.ipscan
    io.emeric.toolblex
)

archives=(
    # !Development
    # flatpak install flathub com.github.flathub.Flathub-Slack
    # flatpak install flathub com.github.slack.Slack-desktop
    # flatpak install flathub com.github.slack.Slack-beta

    # !Productivity
    # flatpak install flathub com.github.canonical.Calendar
    # flatpak install flathub com.github.taydenwilliams.Trello
    # flatpak install flathub com.github.benlau.todoist
    # flatpak install flathub com.github.Eloston.Google-Chrome
    # flatpak install flathub com.github.Eloston.Chrome-Canary
    # flatpak install flathub com.github.phillip-scott.GIMP
    # flatpak install flathub com.github.muffinsoft.Muffin
    # flatpak install flathub com.github.jim-easterling.Stardict
    # flatpak install flathub com.github.mattermost.desktop
    # flatpak install flathub com.github.vincent-pond.Pandoc
    # flatpak install flathub com.github.jamiemcc/WebTorrent

    # !Office Suite
    # flatpak install flathub com.libreoffice.LibreOffice
    # flatpak install flathub org.libreoffice.Writer
    # flatpak install flathub org.libreoffice.Calc
    # flatpak install flathub org.libreoffice.Draw
    # flatpak install flathub org.libreoffice.Impress
    # flatpak install flathub org.libreoffice.Math

    # !Messaging
    # flatpak install flathub com.github.mattermost.desktop
    # flatpak install flathub com.github.jitsi.jitsi-meet

    # !Education
    # flatpak install flathub com.github.jonasschmedtmann.mathlive
    # flatpak install flathub com.github.jonasschmedtmann.mathlive-editor
    # flatpak install flathub com.github.jonasschmedtmann.mathlive-presentation
    # flatpak install flathub com.github.jonasschmedtmann.mathlive-diagram

    # !Music and Video
    # flatpak install flathub com.github.vlc-player.VLC
    # flatpak install flathub com.github.videolan.VLC-Web
    # flatpak install flathub com.github.videolan.VLC-Player

    # !Virtual Machines and Container Managers
    # flatpak install flathub org.gnome.Boxes
    # flatpak install flathub io.podman_desktop.PodmanDesktop

    # !Utilites
    # flatpak install flathub com.todoist.Todoist
    # flatpak install flathub com.bitwarden.desktop
    # flatpak install flathub com.github.tchx84.Flatseal
    # flatpak install flathub io.github.flattool.Warehouse
    # flatpak install flathub org.gnome.Logs
    # flatpak install flathub org.gnome.font-viewer
    # flatpak install flathub net.nokyan.Resources

    # !Image Viewer
    # flatpak install flathub org.gnome.Shotwell
    # flatpak install flathub org.gnome.eog
    # flatpak install flathub org.gnome.Loupe

    # !Notes
    # flatpak install flathub md.obsidian.Obsidian
    # flatpak install flathub com.github.xournalpp.xournalpp

    # !SocialMedia
    # flatpak install flathub org.telegram.desktop
    # flatpak install flathub com.discordapp.Discord

    # !Browser
    # flatpak install flathub com.brave.Browser
    # flatpak install flathub io.github.zen_browser.zen

    # !Editor
    # flatpak install flathub org.spyder_ide.spyder
    # flatpak install flathub org.jupyter.JupyterLab
    # flatpak install flathub org.gnome.Builder
    # flatpak install flathub com.google.AndroidStudio
    # flatpak install flathub io.beekeeperstudio.Studio
    # flatpak install flathub ca.desrt.dconf-editor

    # !Kali-Linux Apps
    # flatpak install flathub org.angryip.ipscan
    # flatpak install flathub io.emeric.toolblex

    # !Animations 
    # flatpak install flathub org.blender.Blender

    # !API Testing
    # flatpak install flathub com.getpostman.Postman
    # flatpak install flathub rest.insomnia.Insomnia

    # !Gnome Apps
    # flatpak install flathub com.obsproject.Studio
    # flatpak install flathub com.spotify.Client
    # flatpak install flathub org.gnome.Maps
    # flatpak install flathub org.gimp.GIMP
    # flatpak install flathub org.filezillaproject.Filezilla
    # flatpak install flathub io.github.shiftey.Desktop
    # flatpak install flathub org.gnome.baobab
    # flatpak install flathub org.gnome.Epiphany
        
    # !Gimp Plugins
    # flatpak install flathub org.gimp.GIMP.Plugin.GMic
    # flatpak install org.gimp.GIMP.Plugin.Resynthesizer
    # flatpak install org.gimp.GIMP.Plugin.LiquidRescale
    # flatpak install org.gimp.GIMP.Plugin.Lensfun org.gimp.GIMP.Plugin.GMic
    # flatpak install org.gimp.GIMP.Plugin.Fourier org.gimp.GIMP.Plugin.FocusBlur
    # flatpak install org.gimp.GIMP.Plugin.BIMP


    # flatpak install flathub com.github.jkotra.eovpn
    # flatpak install flathub io.github.congard.qnvsm
    # flatpak install flathub com.expidusos.file_manager
    # flatpak install flathub io.github.prateekmedia.appimagepool
    # flatpak install flathub com.leinardi.gwe
    # flatpak install flathub eu.nokun.MirrorHall
    # flatpak install flathub org.gnome.Firmware
    # flatpak install flathub org.dupot.easyflatpak
    # flatpak install flathub com.geekbench.Geekbench6
    # flatpak install flathub org.virt_manager.virt-manager
    # flatpak install flathub net.xmind.XMind
    # flatpak install flathub org.kde.index
    # flatpak install flathub org.virt_manager.virt-manager
)