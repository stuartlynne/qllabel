#!/bin/bash


INSTALL="y"

if [ \! -d "/opt/brother/PTouch/ql710w" ] ; then
    echo -en "\nBrother LPR driver for ql710w not installed, see README-QLLABELS.txt\n\n";
    INSTALL="n"
fi

if [ \! -d "/opt/brother/PTouch/ql1060n" ] ; then
    echo -en "\nBrother LPR driver for ql1060n not installed, see README-QLLABELS.txt\n\n";
    INSTALL="n"
fi


if [ \! -d "/usr/lib/cups/filter" ] ; then
    echo -en "\n/usr/lib/cups/filter directory is missing, CUPS or LPR must be installed\n\n";
    INSTALL="n"
fi

if [ \! -d "/usr/share/cups/model/Brother" ] ; then
    echo -en "\n/usr/share/cups/model/Brother directory is missing, CUPS or LPR must be installed\n\n";
    INSTALL="n"
fi


set -x
[ "${INSTALL}" = "y" ] && echo Brother drivers found || exit 1


cp filter/brother_lpdwrapper_labels /usr/lib/cups/filter/brother_lpdwrapper_labels

pushd /usr/lib/cups/filter/
chmod 755 brother_lpdwrapper_labels
ln -s brother_lpdwrapper_labels brother_lpdwrapper_102x152
ln -s brother_lpdwrapper_labels brother_lpdwrapper_62x100
popd

cp model/Brother/* /usr/share/cups/model/Brother

cp bin/qlps2raster /usr/local/bin
pushd /usr/local/bin
ln -s qlps2raster qlps2raster_62x100
ln -s qlps2raster qlps2raster_102x152
