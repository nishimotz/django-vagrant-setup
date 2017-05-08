from selenium import webdriver
from pyvirtualdisplay import Display
display = Display(visible=0, size=(1024, 768))
display.start()
browser = webdriver.Firefox()
browser.get('http://localhost:8000')
browser.save_screenshot('django.png')
assert 'Django' in browser.title
display.stop()
