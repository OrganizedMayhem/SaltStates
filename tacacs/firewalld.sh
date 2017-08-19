sudo firewall-cmd --zone=public --add-service=radius --permanent
sudo firewall-cmd --zone=public --add-interface=eth0 --permanent
sudo firewall-cmd --zone=public --add-port=49/tcp --permanent
sudo firewall-cmd --reload
sleep 10
systemctl restart tac_plus.service
