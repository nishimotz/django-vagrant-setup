sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential
sudo apt-get -y install libsqlite3-dev
sudo apt-get -y install libreadline6-dev
sudo apt-get -y install libgdbm-dev
sudo apt-get -y install zlib1g-dev
sudo apt-get -y install libbz2-dev
sudo apt-get -y install sqlite3
sudo apt-get -y install tk-dev
sudo apt-get -y install zip
sudo apt-get -y install libssl-dev
sudo apt-get -y install gfortran
sudo apt-get -y install liblapack-dev
wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
tar axvf ./Python-3.6.1.tgz
cd ./Python-3.6.1/
LDFLAGS="-L/usr/lib/x86_64-linux-gnu" ./configure --with-ensurepip
make
sudo make install
