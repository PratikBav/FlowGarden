import urllib.request
import re

queries = ['matcha', 'meditation-cushion', 'face-roller', 'superfood-powder', 'incense', 'cashmere']
for q in queries:
    try:
        req = urllib.request.Request('https://unsplash.com/s/photos/' + q, headers={'User-Agent': 'Mozilla/5.0'})
        html = urllib.request.urlopen(req).read().decode('utf-8')
        ids = re.findall(r'\"/(photos|images)/([a-zA-Z0-9\-_]{11})\"', html)
        valid_ids = [i[1] for i in ids]
        if valid_ids:
            print(f'{q}: {valid_ids[0]}')
        else:
            print(f'{q}: NONE')
    except Exception as e:
        print(f'{q}: ERROR {e}')
