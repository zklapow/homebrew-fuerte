# Installing Fuerte on OS X.

Install `command_line_tools_for_Xcode.dmg` from connect.apple.com OR Xcode from the app store

Install Homebrew:

    /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

Update Homebrew (this initializes the git repo):

    brew update

Install the brew-tap external command:

    brew pull 6086

Install the httparty ruby gem:

    sudo gem install httparty

Add the ros-dep brew tap:

    brew tap add ros-dep

Install pip:

    sudo easy_install pip

Install PyYAML:

    sudo pip install PyYAML

Install rosinstall:

    sudo pip install -U mercurial
    brew tap install ros/fuerte/pysvn
    sudo pip install -U rosinstall

Amend PYTHON_PATH with your `~/.bashrc`:

    echo 'export PYTHONPATH="/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH"' >> ~/.bashrc
    source ~/.bashrc

Install catkin:

    brew tap install ros/fuerte/catkin

Get the ROS source code:

    rosinstall -n ~/ros 'https://raw.github.com/willowgarage/catkin/master/test/test.rosinstall'

Remove the rx directory:

    cd ~/ros
    rm -rf rx

Get the "toplevel" cmake file:

    brew install wget
    wget 'https://raw.github.com/willowgarage/catkin/master/toplevel.cmake' -O CMakeLists.txt

Install dependencies (to be replaced with rosdep2):

    brew tap install ros/fuerte/boost
    brew tap install ros/fuerte/gtest
    brew tap install ros/fuerte/log4cxx
    brew tap install ros/fuerte/qt
    brew tap install ros/fuerte/swig-wx

Build ROS:

    mkdir build
    cd build
    cmake ..
    make

## NOTES:

* rosinstall should depend on pypi's PyYAML on OS X
