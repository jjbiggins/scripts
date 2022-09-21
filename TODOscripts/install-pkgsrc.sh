#!/bin/bash
#CVS_RSH=ssh cvs -danoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc
 CVS_RSH=ssh cvs -danoncvs@anoncvs.NetBSD.org:/cvsroot checkout -r pkgsrc-2022Q1 -P pkgsrc
cd pkgsrc/bootstrap
./bootstrap --prefix /opt/pkg-2022Q1 --prefer-pkgsrc yes --make-jobs 4
cd pkgsrc/devel/memcached
make install clean
