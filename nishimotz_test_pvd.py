from selenium import webdriver
from pyvirtualdisplay import Display
display = Display(visible=0, size=(1024, 768))
display.start()
browser = webdriver.Firefox()
browser.get('http://nishimotz.com')
browser.save_screenshot('nishimotz_pvd.png')
assert 'Nishimoto' in browser.title
display.stop()
