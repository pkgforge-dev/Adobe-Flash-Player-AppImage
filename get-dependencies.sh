#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm libvdpau libvdpau-va-gl

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
echo '# Maintainer: Fifty Dinar <somemail@lol.com>

pkgname=libflashsupport-pulse-mod-git
pkgver=1.0
pkgrel=1
pkgdesc="Improved sound output library for flash player on linux (PulseAudio mod)"
arch=('x86_64')
url="https://github.com/necroflasher/libflashsupport-pulse-mod"
license=('unknown')
depends=('libpulse')
makedepends=('git' 'make')
provides=('libflashsupport')
conflicts=('libflashsupport')
source=("git+https://github.com/necroflasher/libflashsupport-pulse-mod.git")
md5sums=('SKIP')

pkgver() {
  cd "$srcdir/${pkgname%-git}"
  printf "r%s.g%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
  cd "$srcdir/${pkgname%-git}"
  make libflashsupport.so
}

package() {
  cd "$srcdir/${pkgname%-git}"
  install -Dm755 libflashsupport.so "$pkgdir/usr/lib/libflashsupport.so"
}' > ./PKGBUILD
make-aur-package
find /usr/lib | grep libflashsupport
rm ./PKGBUILD
make-aur-package gtk2-ng-git
make-aur-package flashplayer-standalone

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
