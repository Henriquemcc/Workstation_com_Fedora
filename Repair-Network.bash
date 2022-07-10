#!/bin/bash

# Restarting network services
sudo systemctl restart network-online.target NetworkManager.service NetworkManager-wait-online.service NetworkManager-dispatcher.service