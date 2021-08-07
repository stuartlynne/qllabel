# QLLabels 


The QLLabels package is a set of scripts to support the use of
Brother QL710W and QL1060N network label printers with
specific sizes of labels.

They are designed for use with the RaceDB race management system to allow
it to print 2.5"x4" and 4"x6" labels.

Two scripts are provided:
'''
  bin/LABELS
  bin/qlps2raster
  bin/qlps2raster_102x15s -> qlps2raster
  bin/qlps2raster_62x100 -> qlps2raster
'''

This package will typically be used in conjuction with the qlmuxd program. 

## bin/LABELS

The *LABELS* script is called by RaceDB to print labels. It will be provided with
the type of label to be printed and will direct the PDF data on STDIN to
the appropriate printer after being rasterized.

The LABELS script is called by RaceDB to print two different sizes of
labels with several types of information:

For 2"x4":
- type-Tag 
- type-Frame
- type-Shoulder
- type-Emergency

For 4"x6":
- type-Body

The LABELS script will  use the type to queue the file sent by RaceDB
to the appropriate printer via qlmuxd after rasterizing it with the *qlps2raster*
script. 

N.B. the *LABELS* script uses the *qlstatus* script (from qlmux package) to check 
that the *qlmuxd* daemon is running and get the printer status.

N.B. the *LABELS* script uses the *acpi* program (from the acpi debian package) to 
check for battery status.

## bin/qlps2raster

This script uses Brother provided tools to rasterize a PDF file on input for 
printing on QL710W and QL1060N printers.

Only two sizes of labels are supported:
'''
  62mmx100mm (2.4"x4")    QL710W
  102mmx152mm (4"x6")     QL1060n
'''
This script does not require the Brother Linux CUPS filter.

There are two model ppd files available, these should be installed in:
'''
  /usr/share/cups/model/Brother/brother_102x152.ppd
  /usr/share/cups/model/Brother/brother_62x100.ppd
'''
The script does require that the Brother Linux LPR support be installed:

  ql1060nlpr-1.0.1-0.i386.deb  
  ql710wlpr-1.0.2-0.i386.deb

The only files used from those packages are:
'''
  /opt/brother/PTouch/ql710w/lpd/rastertobrpt1
  /opt/brother/PTouch/ql710w/inf/ImagingArea
  /opt/brother/PTouch/ql710w/inf/paperinfql710wpt1
  /opt/brother/PTouch/ql1060n/lpd/rastertobrpt1
  /opt/brother/PTouch/ql1060n/inf/ImagingArea
  /opt/brother/PTouch/ql1060n/inf/paperinfql710wpt1
'''

These are available for download from the Brother support web site.

## qlmux

The *qlmuxd* deamon is installed in a separate python package.

*qlmuxd* acts as a multiplexor sending rasterized files to a pool of printers. 
Two sizes of printers are supported with two printer targets per size. 

Data is received by *qlmuxd* on a TCP port that designates the pool and target. 
it will direct the data to a printer from that pool.

| Pool | Antenna | Printer | Port |
| ---- | ------- | ------- | ---- |
| small | 1/2 | ql710W | 9001 |
| small | 3/4 | ql710W | 9002 |
| large | 1/2 | ql1060n | 9003 |
| large | 3/4 | ql1060n | 9002 |

*qlmuxd* uses *SNMP* to monitor the printer availability and if it has labels. 
Printers that are not working will not skipped with labels going to an alternate.


## Labels

The labels are easily sourced at low cost on Amazon (typically $10/roll in quantity 10 rolls).

    QL1060N - DK-1241 2"x4" - 200
    QL710W  - DK-1201 2-3/7"x4" - 300

## Required Packages
### Brother debian packages
-  ql1060nlpr-1.0.1-0.i386.deb  
-  ql710wlpr-1.0.2-0.i386.deb

### Linux debian
- acpi



### Updated: Mon Jan 27 22:38:46 PST 2020 

