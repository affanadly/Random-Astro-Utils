#!usr/bin/bash

echo "jive5ab Installer"
HOMEDIRECTORY=$(pwd)

echo "Installing pre-requisites..."
sudo apt-get install -y build-essential git cmake

cd /tmp/
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/g++-4.8_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libstdc++-4.8-dev_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/gcc-4.8-base_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/gcc-4.8_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libgcc-4.8-dev_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/cpp-4.8_4.8.5-4ubuntu8_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/universe/g/gcc-4.8/libasan0_4.8.5-4ubuntu8_amd64.deb

sudo dpkg -i g++-4.8_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i libstdc++-4.8-dev_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i gcc-4.8-base_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i gcc-4.8_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i libgcc-4.8-dev_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i cpp-4.8_4.8.5-4ubuntu8_amd64.deb
sudo dpkg -i libasan0_4.8.5-4ubuntu8_amd64.deb

echo "Downloading jive5ab source codes..."
cd /usr/src/
sudo git clone https://github.com/jive-vlbi/jive5ab.git

echo "Installing jive5ab..."
cd /tmp/
cmake -DSSAPI_ROOT=nossapi -DCMAKE_C_COMPILER=gcc-4.8 -DCMAKE_CXX_COMPILER=g++-4.8 /usr/src/jive5ab
make
sudo make install

echo "Install complete. Run by using the command 'jive5ab-<version goes here>-64bit-Debug' (try 'jive5ab' and press tab to autocomplete)."
cd $HOMEDIRECTORY