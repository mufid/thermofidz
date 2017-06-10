#!/usr/bin python

import sys
import os
import json
from datetime import datetime, timedelta

os.environ["TZ"]="Asia/Jakarta"

temp = sys.stdin.read().strip()

now = datetime.now()
os.system("mkdir -p docs/build/%02d/%02d" % (now.year, now.month))
target_file = "docs/build/%02d/%02d/%02d-%02d-%02d.json" % (now.year, now.month, now.year, now.month, now.day)

if os.path.isfile(target_file):
    with open(target_file) as data_file:
        data = json.loads(data_file.read())
else:
    data = []

print(temp)

obj = {
    'local_time': now.isoformat(),
    'temp': temp
}
data.append(obj)
print(data)

with open(target_file, 'w') as data_file:
    json.dump(data, data_file, indent=2)
