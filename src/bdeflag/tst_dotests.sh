:

TMP=/tmp/dotests.$$

SRCS="tst_test.h tst_test.cpp tst_test2.cpp tst_pcre.h tst_pcre.cpp
      tst_friendship.h tst_funcsec.h
      tst_bcep_multiqueuethreadpool.h
      tst_bael_log.h tst_bael_log.cpp tst_bael_log.t.cpp
      tst_btemt_channelpool.h tst_btemt_channelpool.cpp
      tst_btemt_channelpool.t.cpp
      tst_bcep_fixedthreadpool.cpp tst_bcep_fixedthreadpool.h
      tst_bcep_fixedthreadpool.t.cpp
      tst_bcep_threadpool.cpp tst_bcep_threadpool.h
      tst_bcep_threadpool.t.cpp
      tst_unbalanced1.cpp
      tst_unbalanced2.cpp
      tst_unbalanced3.cpp
      tst_unbalanced4.cpp
      tst_unbalanced5.cpp
      tst_unbalanced6.cpp
      tst_decimal.h
      tst_bcec_deque.h"

runit() {
    ~bchapman/bin/myBdeflag "$@"
}

for s in $SRCS ; do
    echo $s:
    runit $s 2>$TMP
#   match=$( echo $s | sed -e 's/[.]h$/.right.h/' -e 's/[.]cpp$/.right.cpp/')
    suffix=$(echo $s | sed -e 's/^.*[.]/./')
    match=$( echo $s | sed -e 's/[.][^.]*$//' -e "s/$/.right$suffix/")
    diff $TMP $match
done
rm $TMP

echo "/home/bchapman/bin/myBdeflag --brace-report tst_test.cpp >$TMP" | bash -x
diff $TMP tst_test.brace-report.cpp

runit bdeflag.m.cpp bdeflag_{ut,componenttable,lines}.{h,cpp,t.cpp} \
                                                   bdeflag_place. bdeflag_group