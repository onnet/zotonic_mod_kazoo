
# Update module

```
iam@Telepark:~$ beta 
Last login: Thu Mar  3 07:37:47 2016
[zotonic@beta ~]$ cd /home/zotonic/zotonic/user/modules/mod_kazoo/
[zotonic@beta mod_kazoo]$ 
[zotonic@beta mod_kazoo]$ 
[zotonic@beta mod_kazoo]$ git pull
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 7 (delta 5), reused 7 (delta 5), pack-reused 0
Unpacking objects: 100% (7/7), done.
From https://github.com/onnet/mod_kazoo
   cc073c1..d12cd44  master     -> origin/master
Updating cc073c1..d12cd44
Fast-forward
 kazoo_util.erl                    | 14 ++++++++++++--
 models/m_kazoo.erl                |  9 +++++++++
 templates/reseller_child_info.tpl | 15 ++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)
[zotonic@beta mod_kazoo]$ 
[zotonic@beta mod_kazoo]$ 
[zotonic@beta mod_kazoo]$ zotonic shell
Erlang/OTP 18 [erts-7.2] [source-e6dd627] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V7.2  (abort with ^G)
(zotonic001@beta)1> z:m().
ok
(zotonic001@beta)2>
(zotonic001@beta)1> 
BREAK: (a)bort (c)ontinue (p)roc info (i)nfo (l)oaded
       (v)ersion (k)ill (D)b-tables (d)istribution
^C[zotonic@beta mod_kazoo]$ 

```
