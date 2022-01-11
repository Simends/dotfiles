import subprocess

config.load_autoconfig()

config.bind(',v', 'spawn mpv {url}')
config.unbind('J', mode='normal')
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
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0'
c.content.headers.do_not_track = True
c.content.blocking.method = 'both'
c.content.canvas_reading = False
c.url.searchengines = {"DEFAULT": "https://duckduckgo.com/?q={}", "wa": "https://wiki.archlinux.org/?search={}"}
c.url.default_page = 'https://start.duckduckgo.com/'
c.url.start_pages = 'https://start.duckduckgo.com/'

c.fonts.statusbar = "SourceCodePro-Regular"
c.fonts.default_family = "SourceCodePro"
c.fonts.default_size = "12pt"
c.qt.highdpi = True
