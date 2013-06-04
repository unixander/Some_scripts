import urllib
import zipfile
import os.path
import sys
import platform

destination = "D:\\Program Files\\Chromium\\" #Where chromium will be installed
systemName = platform.system()

settings = {
    "Windows": {
        "url": "http://commondatastorage.googleapis.com/chromium-browser-snapshots/Win/",
        "name": "chrome-win32",
        "ext": ".zip"
        },
    "Linux": {
        "url": "http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux/",
        "name": "chrome-linux",
        "ext": ".zip"
        }
    }

currentSettings = settings[systemName]
url = currentSettings["url"]
file_name = currentSettings["name"]
file_extension = currentSettings["ext"]

if not (url and file_name and file_extension):
    print "System not recognized. Sorry"
    sys.exit()

old_version = 0
if os.path.exists(destination) and os.path.exists(destination + "VERSION"):
    destFile = open(destination + "VERSION", "r")
    old_version = destFile.readline()

content = urllib.urlopen(url + "LAST_CHANGE")
new_version = content.readline()

try:
    if int(old_version) >= int(new_version):
        print "Chromium v.%s is up to date. No update required." % (old_version)
        sys.exit()
except ValueError:
    print "Something went wrong. Try again later"
    sys.exit()

file_url = url + new_version + "/" + file_name + file_extension

url = urllib.urlopen(file_url)
destFile = open(file_name + file_extension, 'wb')
meta = url.info()
file_size = int(meta.getheaders("Content-Length")[0])
print "Downloading: %s Bytes: %s" % (file_name + file_extension, file_size)

file_size_dl = 0
block_size = 8192
while True:
    buff = url.read(block_size)
    if not buff:
        break
    file_size_dl += len(buff)
    destFile.write(buff)
    status = r"%10d [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
    status = status + chr(8) * (len(status) + 1)
    print status,
destFile.close()
print "Download completed successfully"

if not os.path.exists(destination):
    os.mkdir(destination)
destFile = open(destination + "VERSION", "w")
destFile.write(new_version)
destFile.close()

zip_file = zipfile.ZipFile(file_name + file_extension)
file_list = zip_file.namelist()
quantity = len(file_list)
i = 0
for name in file_list:
    (dirname, filename) = os.path.split(name)
    if not os.path.exists(destination + dirname[len(file_name) + 1:]):
        os.mkdir(destination + dirname[len(file_name) + 1:])
    destFile = open(destination + name[name.find('/'):], "wb")
    destFile.write(zip_file.read(name))
    destFile.close()
    i += 1
    status = r"%10d files extracted [%3.2f%%]" % (i, i * 100. / quantity)
    status = status + chr(8) * (len(status) + 1)
    print status,
print '\r'
print "Operation completed successfully"
zip_file.close()
os.remove(file_name + file_extension)
print "Chromium updated to version %s" % (new_version)
