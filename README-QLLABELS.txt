QLLabels                                                    Stuart Lynne
Wimsey                                      Sun Nov 20 22:59:45 PST 2016 


The QLLabels package is a simple set of scripts to support simple setup
and use of the Brother QL710W and QL1060N network label printers with
specific sizes of labels with the Linux CUPS printing system.

This is designed for use with the RaceDB race management system to allow
it to print 2.5"x4" and 4"x6" labels.

The following files are provided:

A script to be called by RaceDB to print labels. It will be provided with
the type of label to be printed and will direct the PDF data on STDIN to
the appropriate printer with the lp command:

    bin/LABELS

The LABELS script is called by RaceDB to print two different sizes of
labels with several types of information:

For 2"x4"
    type-Tag 
    type-Frame
    type-Shoulder
    type-Emergency

For 4"x6"
    type-Body

The LABELS script will  use the type to queue the file sent by RaceDB
to the appropriate printer or printer class:

    QL710W - for 2"x4"
    QL1060N - for 4"x6"

A single printer can be used as the target, or multiple printers in a 
printer class.


The following provide the CUPS printer support:

    filter/brother_lpdwrapper_labels
    filter/brother_lpdwrapper_102x152 ->brother_lpdwrapper_labels
    filter/brother_lpdwrapper_62x100 ->brother_lpdwrapper_labels
    model/Brother/brother_102x152.ppd
    model/Brother/brother_62x100.ppd

The filter file should be installed in:

    /usr/lib/cups/filter/brother_lpdwrapper_labels
    /usr/lib/cups/filter/brother_lpdwrapper_102x152 -> brother_lpdwrapper_labels
    /usr/lib/cups/filter/brother_lpdwrapper_62x100 -> brother_lpdwrapper_labels

There are two model ppd files available, these should be installed in:

    /usr/share/cups/model/Brother/brother_102x152.ppd
    /usr/share/cups/model/Brother/brother_62x100.ppd


It requires that the Linux LPR support be installed or CUPS:
    

It requires that the Brother Linux LPR support be installed:

    ql1060nlpr-1.0.1-0.i386.deb  
    ql710wlpr-1.0.2-0.i386.deb

These are available for download from the Brother support web site.

The only files used from those packages are:

    /opt/brother/PTouch/ql710w/lpd/rastertobrpt1
    /opt/brother/PTouch/ql710w/inf/ImagingArea
    /opt/brother/PTouch/ql710w/inf/paperinfql710wpt1
    /opt/brother/PTouch/ql1060n/lpd/rastertobrpt1
    /opt/brother/PTouch/ql1060n/inf/ImagingArea
    /opt/brother/PTouch/ql1060n/inf/paperinfql710wpt1
 


For Linux we will have one or more printers added to the CUPS printing system. E.g.:

  Printers: 
      1. QL710W1 - first 2x4 printer
      2. QL710W2 - second 2x4  printer
      3. QL1060n1 - first 4x6 printer
      4. QL1060n1 - second 4x6 printer
  Classes:
      1. QL710W 
          - QL710W1
          - QL710W2
      2. QL1060N
          - QL1060N1
          - QL1060N2

Multiple printers of each type is not required. But if available it improves throughput.
Also if one printer runs out of labels the other continues to work alone until it is refilled.

The alternative with multiple printers is to allocate them to different registration
tables. E.g. table with Antenna 0 and 1 get first printer and the table with Antenna 2 and 3
get the second printer.

Additional label sizes can be added to the PPD  file if required. See the various Brother
QL CUPS wrapper packages for more extensive PPD files. 

N.B. The QL Printers will NOT printer correctly if they do not have the correct labels
installed. They will simply turn their status LED to red to indicate that there is a 
problem.

The labels are easily sourced at low cost on Amazon (typically $10/roll in quantity 10 rolls).

    QL1060N - DK-1241 2"x4" - 200
    QL710W  - DK-1201 2-3/7"x4" - 300







Updated: Fri Aug 25 23:06:28 PDT 2017 

