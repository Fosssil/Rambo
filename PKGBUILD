# Maintainer = Sagar Dahiya <fosssil@github.com>
pkgname=rambo
pkgver=0.0.1
pkgrel=1
pkgdesc="A Backub and Restore Utility"
arch=('any')
url="https://github.com/fosssil/rambo"
licence=('GPL')
depends=(

'dialog'
'fzf'
'tar'
'exa'
'tree'

)

package() {

cd $srcdir
chmod +x install.sh
./install.sh $pkgdir

}
