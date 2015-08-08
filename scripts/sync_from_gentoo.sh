#!/usr/bin/env bash
source /lib/gentoo/functions.sh
OVERLAY_DIR=$(pwd)
GENTOO_REPO="/var/lib/portage/repos/gentoo"
FUNTOO_REPO="/var/lib/portage/repos/funtoo"
GNOME_REPO="/var/lib/portage/repos/funtoo-gnome-overlay"

if [[ -e ./profiles/repo_name ]]; then
    einfo "Syncing packages from gentoo"
    einfo "Overlay ($(cat ./profiles/repo_name))"
else
    eerror  "run this script from the top dir of the overlay"
    exit 1
fi

sync_with_gentoo() {
    update_repos
    for package in  $(cat scripts/from_gentoo.txt) ; do
        local forked_on_funtoo=0
        if [[ -d $FUNTOO_REPO/$package || -d $GNOME_REPO/$package ]] ; then
            forked_on_funtoo=1;
            einfo "$package forked on funtoo";
        else
            remove_synced_package $package;
            continue;
        fi
        sync_package $package
    done
}
# Checks differneces and syncs if necessary
sync_package (){
    einfo " syncing package $1"
    local package=$1
    local first_commit=0
    if [[ ! -d ./$package ]] ; then 
        einfo "Creating directory for unsynced package: $package"
        mkdir -p ./$package 
        first_commit=1
    fi
    diff -r -q -x ChangeLog -x Manifest "$GENTOO_REPO/$package" "$PWD/$package" 
    if [[ $? -gt 0 ]] ; then 
        einfo "Rsyncing $package"
        rsync  --exclude=Manifest --exclude=ChangeLog -v -a  "$GENTOO_REPO/$package/" "$(pwd)/$package/"
        einfo "Regenerating Manifest and commiting changes"
        pushd $package
        sudo repoman manifest
        git add ./*
        if [[ $first_commit = 1 ]] ; then 
            git commit -m  "$package: use gentoo's package" ;
        else
            git commit -m  "$package: update from gentoo's package" ;
        fi
        popd
        einfo "Sucess!!  $package"
    else
        einfo "Package $package is already synced"
    fi

}

remove_synced_package (){
    ewarn " You should remove $1 seems not forked on funtoo"
}

update_repos(){
    pushd $FUNTOO_REPO
    git fetch && git pull
    popd
    pushd $GNOME_REPO
    git fetch && git pull
    popd
    sudo emerge --sync
}

sync_with_gentoo
# vim: set ts=4 et 
