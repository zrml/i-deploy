#!/bin/bash

# VARs 
# IRIS-2019.1.0SQL.317.0-lnxrhx64.tar.gz
dist_product=IRIS
dist_ver=2019.1.0SQL
dist_build=317.0
dist_plat=lnxrhx64
dist_name=$dist_product-$dist_ver.$dist_build-$dist_plat
dist_extension=.tar.gz

dist_filename=$dist_name$dist_extension

# %Installer 
#export ISC_INSTALLER_MANIFEST=/home/luca/gs/installer_v0.xml
#export ISC_INSTALLER_LOGFILE=/home/luca/gs/installer.log
#export ISC_INSTALLER_LOGLEVEL=3

# silent installer
export IRISSYS=/home/luca/IRIS1
export ISC_PACKAGE_INSTANCENAME=LMR1
export ISC_PACKAGE_INSTALLDIR=/ssd1/LMR1
export ISC_PACKAGE_INITIAL_SECURITY="Normal"
export ISC_PACKAGE_MGRUSER="luca"
export ISC_PACKAGE_MGRGROUP="develop"
export ISC_PACKAGE_USER_PASSWORD="Ravazzolo99"
export ISC_PACKAGE_IRISUSER="luca"
export ISC_PACKAGE_IRISGROUP="develop"


tar zxf $dist_filename
cd $dist_name
./irisinstall_silent

printf "_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n" | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(%SYSTEM.OBJ).Load(\"/home/luca/gs/installer_v1.xml\",\"cdk\")"
printf "_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n" | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(GS.Installer1).implementDesiredSystemState()"
iris restart $ISC_PACKAGE_INSTANCENAME
printf "_SYSTEM\n$ISC_PACKAGE_USER_PASSWORD\n" | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(GS.Installer2).createDBConfigShards()"
