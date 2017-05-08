from selenium import webdriver
browser = webdriver.Firefox()
browser.get('http://nishimotz.com')
browser.save_screenshot('nishimotz.png')
assert 'Nishimoto' in browser.title
