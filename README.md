# Making An Apt Repository

## Scripts
- make_clean.sh - Cleans up artifacts created by scripts
  - Shouldn't be required, but useful for troubleshooting
- make_repo.sh - Creates artifcats required by Debian/Ubuntu
  - Required after new packages added to pool

## GPG
- First, create the key
  - `gpg --pinentry-mode loopback --gen-key`
    - pinentry-mode loopback is useful for connections with no tty
    - Instead of providing Full Name and Email, this example uses `dpkg1` as the "Full Name" with no email
    - No passphrase provided, to enable scripting
- Export the public key (Binary Format, for Apt)
  - `gpg --export -u dkpg1 --output apt_repo.pub.gpg`

## Directory Structure - Pre Script
```text
root@mirror:/mirror/download.docker.com# tree
.
├── apt_repo.pub.gpg
├── dists
│   └── bionic
│       ├── pool
│       │   └── stable
│       │       └── amd64
│       │           ├── containerd.io_1.2.10-2_amd64.deb
│       │           ├── docker-ce-cli_19.03.3~3-0~ubuntu-bionic_amd64.deb
│       │           └── docker-ce_19.03.3~3-0~ubuntu-bionic_amd64.deb
│       └── stable
│           └── binary-amd64
├── make_clean.sh
└── make_repo.sh

7 directories, 6 files
```

## Directory Structure - Post Script
```text
root@mirror:/mirror/download.docker.com# tree
.
├── apt_repo.pub.gpg
├── dists
│   └── bionic
│       ├── InRelease
│       ├── Release
│       ├── Release.gpg
│       ├── pool
│       │   └── stable
│       │       └── amd64
│       │           ├── containerd.io_1.2.10-2_amd64.deb
│       │           ├── docker-ce-cli_19.03.3~3-0~ubuntu-bionic_amd64.deb
│       │           └── docker-ce_19.03.3~3-0~ubuntu-bionic_amd64.deb
│       └── stable
│           ├── Contents-amd64
│           ├── Contents-amd64.bz2
│           ├── Contents-amd64.gz
│           └── binary-amd64
│               ├── Packages
│               ├── Packages.bz2
│               ├── Packages.gz
│               └── Release
├── make_clean.sh
├── make_repo.sh
└── release.conf

7 directories, 17 files
```