#!/bin/bash

mkdir -p /var/run/sshd

PASS=passw0rd
id -u default &>/dev/null || useradd --create-home --shell /bin/bash --user-group --groups adm,sudo default
echo "default:$PASS" | chpasswd

mkdir /home/default/.x11vnc
x11vnc -storepasswd $PASS /home/default/.x11vnc/passwd

mkdir -p /home/default/.config/lxpanel/LXDE/panels/
cp -f /root/panel /home/default/.config/lxpanel/LXDE/panels/panel

cp -f /root/lxde-x-terminal-emulator.desktop /usr/share/applications/
rm -f /usr/share/applications/lxterminal.desktop

chown -R default.default /home/default

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

