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

_Note: Ignore any warnings like this: Warning: Could not tap ros/fuerte/boost over mxcl/master/boost as rosdep will be explicitly installing the ros snapshot of formulae._

Install pip:

    sudo easy_install pip

Install libyaml and PyYAML (rosinstall):

    brew install ros/fuerte/libyaml
    sudo pip install --upgrade PyYAML

Install mercurial (rosinstall):

    brew install ros/fuerte/mercurial

_Note: in the future you will be able to install from pip (currently broken) with `sudo pip install --upgrade mercurial`_

Install rosinstall:

    sudo pip install --upgrade rosinstall vcstools

Install empy and nose (catkin):

    sudo pip install --upgrade empy nose

Install catkin:

    brew install ros/fuerte/catkin

Workaround the svn certificate error:

    svn co https://code.ros.org/svn/ros/stacks/ros_comm/trunk /tmp/ros_comm

_Accept the certificate by pressing `p` and then cancel the co with ctrl-c._

Get the ROS source code:

    rosinstall -n --catkin ~/ros 'https://raw.github.com/willowgarage/catkin/master/test/test-nocatkin.rosinstall'

Build ROS:

    mkdir build
    cd build
    cmake ..
    make

## NOTES:

* rosinstall should depend on pypi's PyYAML on OS X
