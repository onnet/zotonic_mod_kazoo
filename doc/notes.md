### Upload initial keys to Zotonic DB

vi mod_kazoo_initial_keys.csv
```
mod_kazoo       page_header     OnNet Innovations Limited
mod_kazoo       sender_name     OnNet Innovations Limited
mod_kazoo       user_agent_string       OnNet WebRTC Agent
mod_kazoo       default_kazoo_timezone  Europe/London
mod_kazoo       signup_service_plan     signup_plan
mod_kazoo       sales_email     iam@onnet.info
mod_kazoo       crm_email       iam@onnet.info
mod_kazoo       default_country RU
mod_kazoo       default_kazoo_language  en-us
mod_kazoo       local_currency_sign     £
mod_kazoo       placeholder_phone       10123456789
mod_kazoo       callingcards_number     (xxx) xxx-xx-0xx
mod_kazoo       callback_number (xxx) xxx-xx-xx
mod_kazoo       rates_file      /home/zotonic/zotonic/user/modules/mod_kazoo/files/unhandled/rates.txt
mod_kazoo       color1  #3DADE7
mod_kazoo       color3  #ffffff
mod_kazoo       color4  #C3C2C2
mod_kazoo       color2  #ee1212
mod_kazoo       kazoo_version   4.00
mod_kazoo       kazoo_super_duper_api_key       f2c66____change___me____ba2d2ca8
mod_kazoo       g_capture_secret        f2c66____change___me____ba2d2ca8
mod_kazoo       g_capture_site_key      f2c66____change___me____ba2d2ca8
mod_kazoo       wss_port        5065
mod_kazoo       kazoo_default_realm     .sip3.onnet.su
mod_kazoo       sip_registrar   sip3.onnet.su
mod_kazoo       kazoo_crossbar_url      https://kz527.onnet.su:8443
mod_kazoo       kazoo_portal_url        https://beta.onnet.info
mod_kazoo       kazoo_blackhole_url     wss://kz527.onnet.su:7777
mod_kazoo       show_finance_info       true
mod_kazoo       payments_list_widget_opened     true
mod_kazoo       numbers_list_widget_opened      true
mod_kazoo       current_services_widget_opened  true
mod_kazoo       contacts_widget_opened  true
mod_kazoo       user_settings_widget_opened     true
mod_kazoo       send_fax_widget_opened  true
```
psql -c "COPY ( select module,key,value from config where module='mod_kazoo' ) TO STDOUT" > mod_kazoo_initial_keys.csv


### Update module

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
