pkgname=dotfiles
pkgver=0.1.0
pkgrel=1
pkgdesc="NixxO desktop dotfiles and direct installer"
arch=('any')
url="https://github.com/nixxoq/dotfiles"
license=('unknown')
install="$pkgname.install"
depends=('bash' 'coreutils' 'git' 'python' 'sudo')

package() {
    local shared_dir="$pkgdir/usr/share/$pkgname"

    install -dm755 "$shared_dir"
    cp -a --no-preserve=ownership "$startdir/home" "$startdir/templates" "$startdir/packages" "$shared_dir/"
    install -Dm755 "$startdir/scripts/render-configs.py" "$shared_dir/scripts/render-configs.py"
    install -Dm755 "$startdir/scripts/install" "$shared_dir/install"
}
