import subprocess

# def read_xresources(prefix):
#     props = {}
#     x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True) lines = x.stdout.split('\n')
#     for line in filter(lambda l : l.startswith(prefix), lines):
#         prop, _, value = line.partition(':\t')
#         props[prop] = value
#     return props

# xresources = read_xresources('*')
# c.colors.statusbar.normal.bg = xresources['*.background']

config.load_autoconfig()

config.bind('n', 'scroll left')
config.bind('e', 'scroll down')
config.bind('i', 'scroll up')
config.bind('o', 'scroll right')
config.bind('h', 'mode-enter insert')
config.bind('l', 'set-cmd-text -s :open')
config.bind('N', 'back')
config.bind('O', 'forward')
config.bind('L', 'set-cmd-text -s :open -t')
config.bind('k', 'search-next')
config.bind('K', 'search-prev')
config.bind(',e', 'spawn mpv {url}')
config.unbind('K', mode='normal')
config.unbind('co', mode='normal')
config.unbind('gt', mode='normal')
config.unbind('gm', mode='normal')
config.unbind('gK', mode='normal')
config.unbind('gJ', mode='normal')
config.unbind('gD', mode='normal')
config.unbind('<Ctrl-Tab>', mode='normal')

c.auto_save.session = False
c.tabs.position = "bottom"
c.tabs.show = "never"
c.tabs.tabs_are_windows = True
c.statusbar.show = "in-mode"
c.scrolling.smooth = False
c.spellcheck.languages = ["en-US", "nb-NO"]
c.content.webgl = False
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:99.0) Gecko/20100101 Firefox/99.0'
c.content.headers.do_not_track = True
c.content.blocking.method = 'both'
c.content.canvas_reading = False
c.url.searchengines = {"DEFAULT": "https://duckduckgo.com/?q={}", "wa": "https://wiki.archlinux.org/?search={}"}
c.url.default_page = 'https://start.duckduckgo.com/'
c.url.start_pages = 'https://start.duckduckgo.com/'

c.fonts.statusbar = "Hurmit Nerd Font"
c.fonts.default_family = "Hurmit Nerd Font"
c.fonts.default_size = "10pt"
c.qt.highdpi = True

c.hints.chars = "arstcdkhneio"
