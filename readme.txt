Test Driven Django Development

2017-05-08 Takuya Nishimoto (nishimotz@gmail.com)


setup:

* Windows 10 x64
* VirtualBox
* Vagrant


http://www.obeythetestinggoat.com/book/chapter_01.html

http://qiita.com/kentaro0919/items/e309aa179d5d0cabeca8 (Japanese)

```
# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 8000, host: 80
end
```

> vagrant up


```
# python_install.sh
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
```

sh /vagrant/python_install.sh


$ which python3
/usr/local/bin/python3

$ python3 -V
Python 3.6.1

$ python3 -m venv env

$ . env/bin/activate

$ cd /vagrant

$ pip install -U selenium


$ sudo apt-get install firefox

$ sudo apt-get install xvfb


http://www.obeythetestinggoat.com/book/pre-requisite-installations.html

https://askubuntu.com/questions/870530/how-to-install-geckodriver-in-ubuntu

https://github.com/mozilla/geckodriver/releases

https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-linux64.tar.gz


$ mkdir -p ~/.local/bin

$ wget https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-linux64.tar.gz

$ pushd ~/.local/bin/

$ tar xvfz /vagrant/geckodriver-v0.16.1-linux64.tar.gz
geckodriver

$ chmod +x geckodriver

$ popd
/vagrant

$ echo 'PATH=~/.local/bin:$PATH' >> ~/.bashrc
$ . ~/.bashrc

$ deactivate
$ . ~/env/bin/activate

$ which geckodriver
/home/ubuntu/.local/bin/geckodriver



http://a-zumi.net/python-centos-selenium/ (Japanese)

================================
method 1: use Xvfb
================================

(second terminal)
$ Xvfb :1 -screen 0 1024x768x8

(first terminal)

$ export DISPLAY=:1.0

```
# nishimotz_test.py
from selenium import webdriver
browser = webdriver.Firefox()
browser.get('http://nishimotz.com')
browser.save_screenshot('nishimotz.png')
assert 'Nishimoto' in browser.title
```

$ python nishimotz_test.py


================================
method 2: use pyvirtualdisplay
================================

$ pip install pyvirtualdisplay


```
# nishimotz_test_pvd.py
from selenium import webdriver
from pyvirtualdisplay import Display
display = Display(visible=0, size=(1024, 768))
display.start()
browser = webdriver.Firefox()
browser.get('http://nishimotz.com')
browser.save_screenshot('nishimotz_pvd.png')
assert 'Nishimoto' in browser.title
display.stop()
```

$ python nishimotz_test_pvd.py


================================================================
Let's work with Django, however, test should be first.
================================================================

$ touch functional_tests.py

```
from selenium import webdriver
from pyvirtualdisplay import Display
display = Display(visible=0, size=(1024, 768))
display.start()
browser = webdriver.Firefox()
browser.get('http://localhost:8000')
browser.save_screenshot('django.png')
assert 'Django' in browser.title
display.stop()
```


$ python functional_tests.py
Traceback (most recent call last):
  File "functional_tests.py", line 6, in <module>
    browser.get('http://localhost:8000')
  File "/home/ubuntu/env/lib/python3.6/site-packages/selenium/webdriver/remote/webdriver.py", line 264, in get
    self.execute(Command.GET, {'url': url})
  File "/home/ubuntu/env/lib/python3.6/site-packages/selenium/webdriver/remote/webdriver.py", line 252, in execute
    self.error_handler.check_response(response)
  File "/home/ubuntu/env/lib/python3.6/site-packages/selenium/webdriver/remote/errorhandler.py", line 194, in check_response
    raise exception_class(message, screen, stacktrace)
selenium.common.exceptions.WebDriverException: Message: Reached error page: about:neterror?e=connectionFailure&u=http%3A//localhost%3A8000/&c=UTF-8&f=regular&d=Firefox%20can%E2%80%99t%20establish%20a%20connection%20to%20the%20server%20at%20localhost%3A8000.


https://docs.djangoproject.com/en/1.11/releases/1.11/

$ pip install django==1.11

$ django-admin.py startproject superlists

(first terminal)

$ cd superlists

$ python manage.py runserver


(second terminal)

$ cd /vagrant
$ . ~/env/bin/activate
$ python functional_tests.py


(first terminal)
Performing system checks...

System check identified no issues (0 silenced).

You have 13 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.

May 08, 2017 - 05:35:33
Django version 1.11, using settings 'superlists.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
[08/May/2017 05:37:15] "GET / HTTP/1.1" 200 1716
Not Found: /favicon.ico
[08/May/2017 05:37:16] "GET /favicon.ico HTTP/1.1" 404 1966
Not Found: /favicon.ico
[08/May/2017 05:37:16] "GET /favicon.ico HTTP/1.1" 404 1966



(second terminal)

$ curl http://127.0.0.1:8000

<!DOCTYPE html>
<html lang="en"><head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <meta name="robots" content="NONE,NOARCHIVE"><title>Welcome to Django</title>
  <style type="text/css">
    html * { padding:0; margin:0; }
    body * { padding:10px 20px; }
    body * * { padding:0; }
    body { font:small sans-serif; }
    body>div { border-bottom:1px solid #ddd; }
    h1 { font-weight:normal; }
    h2 { margin-bottom:.8em; }
    h2 span { font-size:80%; color:#666; font-weight:normal; }
    h3 { margin:1em 0 .5em 0; }
    h4 { margin:0 0 .5em 0; font-weight: normal; }
    table { border:1px solid #ccc; border-collapse: collapse; width:100%; background:white; }
    tbody td, tbody th { vertical-align:top; padding:2px 3px; }
    thead th {
      padding:1px 6px 1px 3px; background:#fefefe; text-align:left;
      font-weight:normal; font-size:11px; border:1px solid #ddd;
    }
    tbody th { width:12em; text-align:right; color:#666; padding-right:.5em; }
    #summary { background: #e0ebff; }
    #summary h2 { font-weight: normal; color: #666; }
    #explanation { background:#eee; }
    #instructions { background:#f6f6f6; }
    #summary table { border:none; background:transparent; }
  </style>
</head>

<body>
<div id="summary">
  <h1>It worked!</h1>
  <h2>Congratulations on your first Django-powered page.</h2>
</div>

<div id="instructions">
  <p>
    Next, start your first app by running <code>python manage.py startapp [app_label]</code>.
  </p>
</div>

<div id="explanation">
  <p>
    You're seeing this message because you have <code>DEBUG = True</code> in your Django settings file and you haven't configured any URLs. Get to work!
  </p>
</div>
</body></html>


https://ubuntuforums.org/showthread.php?t=2260190


$ python manage.py runserver 0.0.0.0:8000


(host Windows Firefox)

http://localhost/

