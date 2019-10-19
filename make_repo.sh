#!/bin/bash

# Release Conf for bionic, supports stable branch
echo 'APT::FTPArchive::Release::Codename "bionic";' > release.conf
echo 'APT::FTPArchive::Release::Components "stable";' >> release.conf
echo 'APT::FTPArchive::Release::Label "Local APT Repository";' >> release.conf
echo 'APT::FTPArchive::Release::Architectures "amd64";' >> release.conf

# Packages - dists/bionic/pool/stable
apt-ftparchive --arch amd64 packages dists/bionic/pool/stable > dists/bionic/stable/binary-amd64/Packages
gzip -q -f -k dists/bionic/stable/binary-amd64/Packages
bzip2 -q -f -k dists/bionic/stable/binary-amd64/Packages

# Contents - dists/bionic/pool/stable
apt-ftparchive contents dists/bionic/pool/stable > dists/bionic/stable/Contents-amd64
gzip -q -f -k dists/bionic/stable/Contents-amd64
bzip2 -q -f -k dists/bionic/stable/Contents-amd64

# Release - dists/bionic/stable
apt-ftparchive release dists/bionic/stable/binary-amd64 > dists/bionic/stable/binary-amd64/Release
apt-ftparchive release -c release.conf dists/bionic > dists/bionic/Release
gpg -a --yes -u dpkg1 --output dists/bionic/Release.gpg  --detach-sign dists/bionic/Release
gpg -a --yes --clearsign -u dpkg1 --output dists/bionic/InRelease  --detach-sign dists/bionic/Release