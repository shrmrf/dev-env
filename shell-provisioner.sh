
set -x

sudo apt-get update

sudo apt-get install -y python-dev python-pip

sudo pip install virtualenv

virtualenv my-env
sudo chown -R vagrant:vagrant my-env

source my-env/bin/activate

pip install pyserial
pip install protobuf


# Now, we get serious!!
# Install ARM toolchain
sudo apt-get install -y libc6-armel-cross libc6-dev-armel-cross
sudo apt-get install -y binutils-arm-linux-gnueabi
sudo apt-get install -y libncurses5-dev

# Board specific stuff...
sudo apt-get install -y gcc-arm-linux-gnueabi
sudo apt-get install -y g++-arm-linux-gnueabi
