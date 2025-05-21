#!/bin/bash

mkdir -p $HOME/bin/

cat > $HOME/bin/wine-runner.sh <<EOF
#!/bin/bash

NAME=\$(basename \$1 | cut -f 1 -d ".")

echo "Windows Executable: \$NAME.exe"

mkdir -p \$HOME/bin/
cp \$1 \$HOME/bin/ 2>/dev/null
# wrestool -x -t 14 \$1 > \$HOME/.local/share/icons/hicolor/16x16/apps/\$NAME.png

echo "Executable: \$HOME/bin/\$NAME.exe"
# echo "Icon: \$HOME/.local/share/icons/\$NAME.png"

cat > \$HOME/.local/share/applications/\$NAME.desktop <<EOL
[Desktop Entry]
Name=\$NAME
Exec=wine \$HOME/bin/\$NAME.exe
Terminal=false
Type=Application
# Icon=\$NAME.png
EOL

echo "Desktop: \$HOME/.local/share/applications/\$NAME.desktop"

wine \$HOME/bin/\$NAME.exe
EOF

chmod +x $HOME/bin/wine-runner.sh

cat > $HOME/.local/share/applications/wine-runner.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Wine Runner
Exec=$HOME/bin/wine-runner.sh %u
Terminal=false
MimeType=application/octet-stream;application/x-ms-dos-executable;application/x-msi;application/x-ms-shortcut;
EOL

rm $BASH_SOURCE
