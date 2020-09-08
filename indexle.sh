#!/bin/bash
curdir=$(pwd)
srvdir=$curdir/srv/pardus
cachedir=$curdir/.cache
rm -rf $cachedir
mkdir -p $cachedir/index
mkdir -p $srvdir/dists/pardus/{main,contrib,non-free}
mkdir -p $srvdir/pool/{main,contrib,non-free}
echo "Begin indexing" >> $srvdir/dists/index.log
date >>  $srvdir/dists/index.log
cd $srvdir
apt-ftparchive -a amd64 packages pool/main > $cachedir/index/Packages.main64
apt-ftparchive -a i386 packages pool/main > $cachedir/index/Packages.main32
apt-ftparchive -a amd64 packages pool/contrib > $cachedir/index/Packages.con64
apt-ftparchive -a i386 packages pool/contrib > $cachedir/index/Packages.con32
apt-ftparchive -a amd64 packages pool/non-free > $cachedir/index/Packages.non64
apt-ftparchive -a i386 packages pool/non-free > $cachedir/index/Packages.non32
#Packages oluşturuldu. Packages kopyalanacak
mkdir -p $cachedir/index/dists/pardus/main/binary-amd64/
mkdir -p $cachedir/index/dists/pardus/main/binary-i386/
mkdir -p $cachedir/index/dists/pardus/non-free/binary-amd64/
mkdir -p $cachedir/index/dists/pardus/non-free/binary-i386/
mkdir -p $cachedir/index/dists/pardus/contrib/binary-amd64/
mkdir -p $cachedir/index/dists/pardus/contrib/binary-i386/
#taşı
mv $cachedir/index/Packages.main64 $cachedir/index/dists/pardus/main/binary-amd64/Packages
mv $cachedir/index/Packages.main32 $cachedir/index/dists/pardus/main/binary-i386/Packages
mv $cachedir/index/Packages.non64 $cachedir/index/dists/pardus/non-free/binary-amd64/Packages
mv $cachedir/index/Packages.non32 $cachedir/index/dists/pardus/non-free/binary-i386/Packages
mv $cachedir/index/Packages.con64 $cachedir/index/dists/pardus/contrib/binary-amd64/Packages
mv $cachedir/index/Packages.con32 $cachedir/index/dists/pardus/contrib/binary-i386/Packages
gzip -k $cachedir/index/dists/pardus/main/binary-amd64/Packages
gzip -k $cachedir/index/dists/pardus/main/binary-i386/Packages
gzip -k $cachedir/index/dists/pardus/non-free/binary-amd64/Packages
gzip -k $cachedir/index/dists/pardus/non-free/binary-i386/Packages
gzip -k $cachedir/index/dists/pardus/contrib/binary-amd64/Packages
gzip -k $cachedir/index/dists/pardus/contrib/binary-i386/Packages
cp -rf $cachedir/index/* $srvdir
echo "Finish indexing" >> $srvdir/dists/index.log
date >>  $srvdir/dists/index.log
echo "" >> $srvdir/dists/index.log
rm -rf $cachedir
