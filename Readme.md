# Unofficial systemd overlay for Funtoo

This overlay contains profiles, ebuilds and everything needed to build systemd
on Funtoo by selecting just the right profiles with epro.

#### **Important notice:**
#### DO NOT post systemd related bugs to the Funtoo bug-tracker

Also keep questions related to systemd out of funtoo channels.

if you have problems or request post create an issue in github.

Installation
================
Create a repo configuration file in <code>/etc/portage/repos.conf/funtoo-systemd.conf</code>
```ini
[funtoo-systemd]
location = /var/lib/portage/repos/funtoo-systemd
sync-type = git
priority = 100
sync-uri = https://github.com/j-g-/funtoo-systemd.git
auto-sync = true

```
And then run 

```shell
# emerge --sync
```
you might also need to add this to your <code>/etc/portage/make.conf</code>


```conf
PORTDIR_OVERLAY="${PORTDIR_OVERLAY} /var/lib/portage/repos/funtoo-systemd"
```

At the moment only eselect can be used tos set the profiles from this overlay

```shell
# eselect profile list
```
Should output :

```shell

...

Currently available flavor profiles:
  ...
  [33]  funtoo-systemd:funtoo/1.0/linux-gnu/flavor/minimal-systemd
  [34]  funtoo-systemd:funtoo/1.0/linux-gnu/flavor/core-systemd
  [35]  funtoo-systemd:funtoo/1.0/linux-gnu/flavor/workstation-systemd
  [36]  funtoo-systemd:funtoo/1.0/linux-gnu/flavor/server-systemd
Currently available mix-ins profiles:
  ...
  [67]  funtoo-systemd:funtoo/1.0/linux-gnu/mix-ins/web-control
```
you can set any of these flavors with:

```shell
# eselect profile <num>
```

