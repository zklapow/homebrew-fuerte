# Installing Fuerte on OS X.

Install `command_line_tools_for_Xcode.dmg` from connect.apple.com OR Xcode from the app store

Update your PATH and PYTHONPATH with your `~/.bashrc`:

    echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
    echo 'export PYTHONPATH="/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH"' >> ~/.bashrc
    source ~/.bashrc

Install Homebrew:

    /usr/bin/ruby -e "$(/usr/bin/curl -fksSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"

Update Homebrew:

    brew update

Add the ros fuerte tap:

    brew tap ros/fuerte

Install pip:

    sudo easy_install pip

Install PyYAML (rosinstall):

    sudo pip install PyYAML

Install mercurial (rosinstall):

    sudo pip install --upgrade mercurial

Install rosinstall:

    sudo pip install --upgrade rosinstall

Install empy (catkin):

    sudo pip install empy

Install catkin:

    brew install ros/fuerte/catkin

Get the ROS source code:

    rosinstall -n --catkin ~/ros 'https://raw.github.com/willowgarage/catkin/master/test/test-nocatkin.rosinstall'

Build ROS:

    mkdir build
    cd build
    cmake ..
    make

## NOTES:

* rosinstall should depend on pypi's PyYAML on OS X
