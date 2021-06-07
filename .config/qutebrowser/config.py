import subprocess

config.load_autoconfig()
def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

#  xresources = read_xresources('*')
#  c.colors.statusbar.normal.bg = xresources['*.background']

c.auto_save.session = True
c.tabs.position = "bottom"
c.tabs.show = "switching"
c.statusbar.show = "in-mode"
c.scrolling.smooth = False

c.fonts.statusbar = "SourceCodePro-Regular"
c.fonts.default_family = "SourceCodePro"
c.fonts.default_size = "12pt"

config.source('nord-qutebrowser.py')
