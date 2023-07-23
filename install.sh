if [ $# -ne 1 ]; then
    echo "Usage: $0 <INSTALLATION PREFIX>"
    exit 1
fi

PREFIX="$1"
STARTDIR=$PWD
BINDIR="$PREFIX/usr/bin"
DATADIR="$PREFIX/usr/lib/rambo"

echo -n "Installing rambo with prefix $Prefix..."

cd $STARTDIR/src
install -d $DATADIR
install -m644 *.sh $DATADIR/
install -m755 main.sh $DATADIR/

install -d $BINDIR
ln -s $DATADIR/main.sh $BINDIR/rambo

echo "done"

exit 0
