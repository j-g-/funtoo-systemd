# Unofficial systemd overlay for Funtoo
=====================================

This overlay contains profiles, ebuilds and everything needed to build systemd
on Funtoo by selecting just the right profiles with epro.


Important notice: 
## DO NOT post systemd related bugs to the Funtoo bug-tracker

Also keep questions related to systemd out of funtoo channels.

if you have problems or request post create an issue in github.

Installation
================
Create a repo configuration file in /etc/portage/repos.conf/funtoo-systemd.conf
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

