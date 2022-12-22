#!/usr/bin/env bash

# Get the list of audio input devices
device_list=$(arecord -l | grep "card" | awk -F: '{print $2}')

# Display the list of devices in a drop-down menu
device=$(whiptail --title "Select recording device" --menu "Choose a device:" 15 60 4 $device_list 3>&1 1>&2 2>&3)

# Check if the user canceled the device selection
if [ $? -eq 1 ]; then
  exit
fi

# Request the user to enter the name of the audio file to be recorded
filename=$(whiptail --inputbox "Enter the name of the audio file:" 8 78 --title "Filename" 3>&1 1>&2 2>&3)

# Check if the user canceled the request for the filename
if [ $? -eq 1 ]; then
  exit
fi

# Start recording audio from the selected device
arecord -D plughw:$device -f cd -t wav $filename
