#  What is this
This is a modified version of the code for the Pimorini cooling fan set to run the Fan slower and quieter using Pulse Width Modulation (PWM).
This is based on version 0.0.4 cloned on February 25th 2020 from https://github.com/pimoroni/fanshim-python  
All the changes made are in "fanshim/library/fanshim/\_\_init\_\_.py".
I have added some tmux files to enable running /examples/automatic.py  automatically at start up.
There is a txt file showing the changes needed to /etc/rc.local
#  Suggested method to install
My  preferred  way to install this software is to clone it using Git and then run it using tmux as described below.
* open a terminal
* make a director using  "mkdir fanshim" so that it is "/home/pi/fanshim"
* clone into that directory using "git clone https://github.com/grayerbeard/fanshim-python-pwm.git  /home/pi/fanshim
* at the /home/pi/fanshim directory enter "sudo ./install.sh"
* go to "/home/pi/fanshim/example" and test by entering
* "python3 automatic.py --on-threshold 45 --off-threshold 47 --delay 6 --brightness 2 –verbose”
*  fan should run as Pi warms up, stop running by typing "ctrl c"
* install tmux if not installed already using "sudo apt install tmux"
* test the tmux file by entering "./tmux_start.sh" check its running with "tmux ls" observe with "tmux a -t fanshim"
* edit "/etc/rc.local" using the command "sudo nano /etc/rc.local" to add
     "sudo -u pi bash /home/pi/fanshim/tmux_start.sh &"
     before "exit 0" at the end of the file.
* reboot and code should run automatically.  You can check its running by entering "tmux ls" in a terminal.

The original method of install and run as detailed below should also work but I have not tested it as I prefer using tmux as I find it easier if I want to check what is going on or make changes.
If on your system you have a different user directory, e.g. on volumio you would have "volumio" instead of "pi" then in every case above replace "pi" with "volumio". (Als edit the directoris in tmux)start.sh to replace "pi" with "volumio")

On some syatms the ./tmux_stress.sh command will not work due to lack of working vcgencmd and stress.

On some other OS like volumio you may also need to do all or some these commands before running the code (after doing sudo ./install.sh)
* sudo apt update
* sudo apt install python3
* sudo apt install python3-pip
* sudo pip3 install RPi.GPIO
* sudo pip3 install psutil --upgrade

Original Pimorini Readme file...........
# Fan Shim for Raspberry Pi

[![Build Status](https://travis-ci.com/pimoroni/fanshim-python.svg?branch=master)](https://travis-ci.com/pimoroni/fanshim-python)
[![Coverage Status](https://coveralls.io/repos/github/pimoroni/fanshim-python/badge.svg?branch=master)](https://coveralls.io/github/pimoroni/fanshim-python?branch=master)
[![PyPi Package](https://img.shields.io/pypi/v/fanshim.svg)](https://pypi.python.org/pypi/fanshim)
[![Python Versions](https://img.shields.io/pypi/pyversions/fanshim.svg)](https://pypi.python.org/pypi/fanshim)

# Installing

Stable library from PyPi:

* Just run `sudo pip install fanshim`

Latest/development library from GitHub:

* `git clone https://github.com/pimoroni/fanshim-python`
* `cd fanshim-python`
* `sudo ./install.sh`

# Reference

You should first set up an instance of the `FANShim` class, eg:

```python
from fanshim import FanShim
fanshim = FanShim()
```

## Fan

Turn the fan on with:

```python
fanshim.set_fan(True)
```

Turn it off with:

```python
fanshim.set_fan(False)
```

You can also toggle the fan with:

```python
fanshim.toggle_fan()
```

You can check the status of the fan with:

```python
fanshim.get_fan() # returns 1 for 'on', 0 for 'off'
```

## LED

Fan Shim includes one RGB APA-102 LED.

Set it to any colour with:

```python
fanshim.set_light(r, g, b)
```

Arguments r, g and b should be numbers between 0 and 255 that describe the colour you want.

For example, full red:

```
fanshim.set_light(255, 0, 0)
```

## Button

Fan Shim includes a button, you can bind actions to press, release and hold events.

Do something when the button is pressed:

```python
@fanshim.on_press()
def button_pressed():
    print("The button has been pressed!")
```

Or when it has been released:

```python
@fanshim.on_release()
def button_released(was_held):
    print("The button has been pressed!")
```

Or when it's been pressed long enough to trigger a hold:

```python
fanshim.set_hold_time(2.0)

@fanshim.on_hold()
def button_held():
    print("The button was held for 2 seconds")
```

The function you bind to `on_release()` is passed a `was_held` parameter,
this lets you know if the button was held down for longer than the configured
hold time. If you want to bind an action to "press" and another to "hold" you
should check this flag and perform your action in the `on_release()` handler:

```python
@fanshim.on_release()
def button_released(was_held):
    if was_held:
        print("Long press!")
    else:
        print("Short press!")
```

To configure the amount of time the button should be held (in seconds), use:

```python
fanshim.set_hold_time(number_of_seconds)
```

If you need to stop Fan Shim from polling the button, use:

```python
fanshim.stop_polling()
```

You can start it again with:

```python
fanshim.start_polling()
```

# Alternate Software

* Fan SHIM in C, using WiringPi - https://github.com/flobernd/raspi-fanshim
* Fan SHIM in C++, using libgpiod - https://github.com/daviehh/fanshim-cpp

