#!/bin/bash
echo "Miriad Installer"
HOMEDIRECTORY=$(pwd)
INSTALLDIR=/usr/local

echo "Installing apt pre-requisites..."
sudo apt-get update
sudo apt-get -y install pgplot5 gfortran autoconf git csh xorg openbox libxaw7-dev libreadline-dev build-essential zlib1g-dev

echo "Downloading source codes..."
wget -nc ftp://ftp.atnf.csiro.au/pub/software/rpfits/rpfits-2.25.tar.gz
wget -nc ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib-7.7.tar.bz2
wget -nc ftp://ftp.atnf.csiro.au/pub/software/miriad/miriad-code.tar.bz2
wget -nc ftp://ftp.atnf.csiro.au/pub/software/miriad/miriad-common.tar.bz2
wget -nc https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.0.0.tar.gz
wget -nc https://www.atnf.csiro.au/people/Matthew.Whiting/Duchamp/downloads/Duchamp-1.6.2.tar.gz
wget -nc ftp://ftp.atnf.csiro.au/pub/software/karma/karma-1.7.25-amd64_Linux_libc6.3.tar.bz2
wget -nc ftp://ftp.atnf.csiro.au/pub/software/karma/karma-1.7.25-common.tar.bz2

echo "Unpacking source codes..."
tar -zxvf rpfits-2.25.tar.gz
tar -jxvf wcslib-7.7.tar.bz2
tar -zxvf cfitsio-4.0.0.tar.gz
tar -zxvf Duchamp-1.6.2.tar.gz
tar -jxvf karma-1.7.25-amd64_Linux_libc6.3.tar.bz2
tar -jxvf karma-1.7.25-common.tar.bz2

echo "Installing RPFITS..."
cd rpfits/linux64
make
sudo make install # PREFIX=$INSTALLDIR/miriad/linux64
cd $HOMEDIRECTORY

echo "Installing WCSLIB..."
cd wcslib-7.7
./configure # --prefix=$INSTALLDIR/miriad/linux64
make
sudo mkdir /usr/local/share/man/man1
sudo make install
cd $HOMEDIRECTORY

echo "Installing Miriad..."
sudo cp miriad-code.tar.bz2 $INSTALLDIR
sudo cp miriad-common.tar.bz2 $INSTALLDIR
cd $INSTALLDIR
sudo tar -jxvf miriad-code.tar.bz2
sudo tar -jxvf miriad-common.tar.bz2
export MIR=$INSTALLDIR/miriad
export MIRARCH=linux64
cd $MIR
sudo ./configure 
sudo make
cd $HOMEDIRECTORY

echo "Installing CFITSIO..."
cd cfitsio-4.0.0
./configure --prefix=$INSTALLDIR
make
sudo make install 
cd $HOMEDIRECTORY

echo "Installing Duchamp..."
cd Duchamp-1.6.2
./configure # --prefix=$INSTALLDIR/miriad/linux64
make
sudo make install
cd $HOMEDIRECTORY

echo "Installing Karma"
sudo mv karma-1.7.25 $INSTALLDIR
cd $INSTALLDIR
sudo mv karma-1.7.25 karma
cd $HOMEDIRECTORY

echo "Removing temporary files..."
cd $INSTALLDIR
sudo rm -r -f miriad-code.tar.bz2
sudo rm -r -f miriad-common.tar.bz2
cd $HOMEDIRECTORY
rm -r -f wcslib-7.7
rm -r -f rpfits
rm -r -f cfitsio-4.0.0
rm -r -f Duchamp-1.6.2

echo "Adding to PATH..."
cat << EOF >> ~/.profile

. $INSTALLDIR/miriad/MIRRC.sh
export PATH=\$PATH:\$MIRBIN
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$MIRLIB

. /usr/local/karma/.karmarc
export KARMABASE=/usr/local/karma
export PATH=\$PATH:\$KARMABASE/amd64_Linux_libc6.3/bin
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$KARMABASE/amd64_Linux_libc6.3/lib
EOF

echo "Installation complete. Run source ~/.profile or restart to use Miriad."