#!/bin/bash
# Install script for OpenCV & TensorFlow for Raspberry Pi
# Author: Michael D'Argenio
# mjdargen@gmail.com
# Based on the very helpful guide from Adrian Rosebrock
# https://www.pyimagesearch.com/2019/09/16/install-opencv-4-on-raspberry-pi-4-and-raspbian-buster/

echo "This script will update your packages, and install new packages to run OpenCV and TensorFlow."
echo "It can take up to 2 hours to run depending upon your system/internet connection."
echo "Upon completion, you may need to reboot your machine before running."
echo "Python 3 should be installed before running script."
sleep 5s

# update packages and remove any unnecessary packages
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes autoclean

# run it again in case any upgrades got caught
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes autoclean

# install dependency packages
sudo apt-get --assume-yes install python3-pip
sudo apt-get --assume-yes install build-essential cmake pkg-config
sudo apt-get --assume-yes install libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
sudo apt-get --assume-yes install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get --assume-yes install libxvidcore-dev libx264-dev
sudo apt-get --assume-yes install libfontconfig1-dev libcairo2-dev
sudo apt-get --assume-yes install libgdk-pixbuf2.0-dev libpango1.0-dev
sudo apt-get --assume-yes install libgtk2.0-dev libgtk-3-dev
sudo apt-get --assume-yes install libatlas-base-dev gfortran
sudo apt-get --assume-yes install libhdf5-dev libhdf5-serial-dev libhdf5-103
sudo apt-get --assume-yes install libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
sudo apt-get --assume-yes install libespeak-dev
sudo apt-get --assume-yes install python3-dev
sudo apt-get --assume-yes install libopencv-dev
sudo apt-get --assume-yes install curl wget

# update and cleanup after installation of packages
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes autoclean

# install PIP
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo rm get-pip.py
sudo rm -rf ~/.cache/pip

# install PIP packages
sudo pip3 install setuptools virtualenv virtualenvwrapper

# setup virtual environment
virtualenv TMenv
source TMenv/bin/activate

# install PIP packages in virtual environment
pip3 install wrapt --upgrade --ignore-installed  # rpi fix
pip3 install -r requirements.txt
pip3 install https://github.com/lhelontra/tensorflow-on-arm/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_armv7l.whl
deactivate

# remove vlc because it hangs certain upgrades
sudo apt-get --assume-yes remove --purge vlc

# update packages and remove any unnecessary packages
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes clean

# maybe reinstall vlc
sudo apt-get --assume-yes install vlc

echo "Done!"
echo "To activate your virtual environment, use command 'source TMenv/bin/activate'."
echo "To exit your virtual enviroment, use command 'deactivate'."
