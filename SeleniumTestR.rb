require 'rubygems'
require 'selenium-webdriver'
require 'securerandom'

=begin
	* Author: Keegan Saunders
	* Note: Certain identifiable HTML elements have been removed and replaced with "redacted"
=end

driver = Selenium::WebDriver.for :chrome
name = ""
driver.manage.timeouts.implicit_wait = 5
driver.get "redacted"

#Finds commit button, clicks
def commit(driver)
	element = driver.find_element(:name => "commit").click()
end

#Generates random alphanumeric name
def Name(name)
	name = SecureRandom.alphanumeric
end

#Login
element = driver.find_element :id => "user_email"
element.send_keys "redacted"
element = driver.find_element :id => "user_password"
element.send_keys "redacted"
commit(driver)

#Nav to  page
element = driver.find_element(:link_text => "s").click()
element = driver.find_element(:link_text => "Add Trial ").click()

#Setup 
element = driver.find_element(:id => "_name").send_keys(name = Name(name))
element = driver.find_element(:id => "_notes").send_keys("This is a test ")
element = driver.find_element(:css => ".radio:nth-child(5) .form-check-input").click() 
element = driver.find_element(:css => ".position-relative:nth-child(3) > .form-control")
platformDrop = Selenium::WebDriver::Support::Select.new(element)
platformDrop.select_by(:text, 'redacted')
element = driver.find_element(:id => "_sku")
skuDrop = Selenium::WebDriver::Support::Select.new(element)
skuDrop.select_by(:index, 1)
element = driver.find_element(:id => "_reason")
reasonDrop = Selenium::WebDriver::Support::Select.new(element)
reasonDrop.select_by(:index, 4)
commit(driver)

#Edit 
element = driver.find_element(:link_text => "Edit ").click()
element = driver.find_element(:id => "_sku")
skuDrop = Selenium::WebDriver::Support::Select.new(element)
skuDrop.select_by(:index, 2)
commit(driver)

#Revoke 
element = driver.find_element(:link_text => "Revoke").click()
element = driver.find_element(:id => "_display_name")
element.send_keys(name)
commit(driver)

#Signout
element = driver.find_element(:css => ".dropdown-toggle").click()
element = driver.find_element(:link_text => "Logout").click()

sleep(10)
driver.quit
