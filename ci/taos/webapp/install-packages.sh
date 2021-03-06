#!/usr/bin/env bash

# Copyright (c) 2018 Samsung Electronics Co., Ltd. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##
# @file       install-packages.sh
# @brief      This script is to install packages that are required to run all modules.
# @dependency apt
# @see      https://github.com/nnsuite/TAOS-CI

echo -e "##########  for CI-server: Installing base packages to set-up taos CI software"
sudo apt -y install bash php curl
sudo apt -y install apache2
sudo apt -y install php php-cgi libapache2-mod-php php-common php-pear php-mbstring
sudo a2enconf php7.0-cgi
sudo systemctl restart apache2

echo -e "########## for CI-system: Installing packages that are required for webapp"
sudo apt -y install top htop

echo -e "########## for CI-system: Installing packages that are required for modules"
sudo apt -y install sed ps cat aha git
sudo apt -y install which grep touch
sudo apt -y install find wc cppcheck

echo -e "########## for CI-system: Installing packages that are required for gcov/lcov"
sudo apt -y install lcov

echo -e "########## for CI-system: Installing clang-format"
if [[ -f /etc/apt/sources.list.d/clang.list ]]; then
    sudo echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-4.0 main" > /etc/apt/sources.list.d/clang.list
    sudo apt -y update
    sudo apt -y install clang-format-4.0
fi

echo -e "########## for CI-system: Installing packages for doxygen documentation"
sudo apt -y install doxygen
sudo apt -y install texlive-latex-base texlive-latex-extra
sudo apt -y install latex-xcolor
sudo apt -y install unoconv
sudo apt -y install pdftk
sudo apt -y install poppler-utils
sudo apt -y install libreoffice
sudo apt -y install evince

echo -e "########## for CI-system: Installing packages for SLOCcount"
sudo apt -y install sloccount

echo -e "########## for CI-system: Setting-up a build environment of Tizen package (.rpm)"
if [[ ! -f /etc/apt/sources.list.d/tizen.list ]]; then
    sudo echo "deb [trusted=yes] http://download.tizen.org/tools/latest-release/Ubuntu_16.04/ / " > /etc/apt/sources.list.d/tizen.list
    sudo apt -y update
    sudo apt -y install mic gbs
fi

echo -e "########## for CI-system: Setting-up a build environment of Ubuntu package (.deb)"
sudo apt -y install pbuilder debootstrap devscripts
echo -e "[DEBUG] Note that you have to write ~/.pbuilderrc file"


echo -e "########## for CI-system: Setting-up a build environment of Yocto package (.deb)"
sudo apt -y install gawk wget git-core diffstat unzip texinfo gcc-multilib 
sudo apt -y install build-essential chrpath socat libsdl1.2-dev xterm
echo -e "[DEBUG] Note that you have to install Extensible SDK (eSDK) directly"


echo -e "[DEBUG] Required packages are successfully installed...."
echo -e "[DEBUG] If some packages are not installed, Please install the packages again."
echo -e "[DEBUG] Then, install the TAOS-CI software as a next step."
