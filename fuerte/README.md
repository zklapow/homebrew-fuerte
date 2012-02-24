# Installing Fuerte on OS X.

1. Install command_line_tools_for_Xcode.dmg from connect.apple.com OR Xcode from the app store

2. Install Homebrew `/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"`

3. Update Homebrew `brew update`

4. Install the brew-tap external command `brew pull 6086`

5. Add the ros-dep brew tap `brew tap add ros-dep`

6. Install pip `sudo easy_install pip`
 * Install PyYAML `sudo pip install PyYAML`

7. Install rosinstall `sudo pip install -U rosinstall`

8. Amend PYTHON_PATH with your ~/.bashrc:

    `echo 'export PYTHONPATH="/usr/local/lib/python2.7/site-packages:/usr/local/lib/python:$PYTHONPATH"' >> ~/.bashrc`
    `source ~/.bashrc`

10. Install catkin `brew tap install ros/fuerte/catkin`



NOTES:

* rosinstall should depend on pypi's PyYAML on OS X
