
set -x
function getLastAptGetUpdate()
{
    local -r aptDate="$(stat -c %Y '/var/cache/apt')"
    local -r nowDate="$(date +'%s')"

    echo $((nowDate - aptDate))
}

function runUpdateCache()
{
    # Default To 24 hours
    updateInterval="$((24 * 60 * 60))"
    lastAptGetUpdate="$(getLastAptGetUpdate)"
    if [[ "${lastAptGetUpdate}" -gt "${updateInterval}" ]]
    then
        sudo apt-get update
    else
        #lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"

        echo "Skip apt-get update because it was run within ${updateInterval}sec"
    fi
}

runUpdateCache

sudo apt-get install -y python-dev python-pip

sudo pip install virtualenv

virtualenv my-env
sudo chown -R vagrant:vagrant my-env # This environment is otherwise owned by root

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

# GUI
sudo apt-get install -y xfce4

