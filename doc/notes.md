# CentOS 7 Zotonic + mod_kazoo = OKUI installation notes
### Note: In order OKUI functions properly [Onbill Kazoo app](https://github.com/onnet/onbill "onbill") should be installed in your Kazoo environment
## Zotonic installation

- yum -y install ImageMagick postgresql-server make git gcc gcc-c++ shorewall inotify-tools libtiff-tools patch epel-release wxGTK python-setuptools libffi-devel openssl-devel python-devel certbot libxslt-devel zip unzip expat zlib-devel curl ncurses-devel git-core htmldoc gcc gcc-c++ openssl-devel expat-devel perl-Image-ExifTool
- yum -y install  http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm
- Install Erlang
```
curl -O https://raw.githubusercontent.com/yrashk/kerl/master/kerl
chmod a+x kerl
mv kerl /usr/bin
kerl list releases
kerl build 18.2 r18.2
kerl install r18.2 /usr/local/erlang
. /usr/local/erlang/activate

vi .bashrc
. /usr/local/erlang/activate
```
- Braintree (don't forget to create plans; create addons and add them to plans... at Braintree itself (through dashboard)
```
easy_install pip
pip install requests[security]
pip install urllib3
pip install braintree
```
- postgresql-setup initdb
- vi /var/lib/pgsql/data/pg_hba.conf (edit lines - exmple isn't secure)
```
# TYPE DATABASE USER CIDR-ADDRESS METHOD
(add lines)

local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust

```
- service postgresql restart
- systemctl enable postgresql
- Install inotify-tools
```
cd /usr/local/src/
wget http://github.com/downloads/rvoicilas/inotify-tools/inotify-tools-3.14.tar.gz
tar xvfpz inotify-tools-3.14.tar.gz 
cd inotify-tools-3.14
./configure 
make
make install
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
```
- ln -s /usr/bin/exiftool /usr/bin/exif
- Install Zotonic
```
useradd zotonic 
passwd zotonic 
su zotonic 
cd /home/zotonic/ 

git clone git://github.com/zotonic/zotonic.git 
cd zotonic 
git checkout 0.x 

vi /home/zotonic/zotonic/src/support/z_utils.erl
===
212: _M:_E -> ok
===
. /usr/local/erlang/activate

make 

vi /home/zotonic/.zotonic/0/zotonic.config
    ,{deps,
     [
      {ibrowse, ".*", {git, "git://github.com/cmullaparthi/ibrowse.git", {branch, "master"}}}
     ]}

make 

vi .bash_profile:
======
PATH=$PATH:$HOME/zotonic/bin
export PATH
=====

vi .bashrc
. /usr/local/erlang/activate

exit  #(back to root env) 

echo "sleep 10" >> /etc/rc.local 
echo 'su - zotonic -c "nohup /home/zotonic/zotonic/bin/zotonic start &"' >> /etc/rc.local 
chmod a+x /etc/rc.local

echo "export ZOTONIC_PORT=80" >> /home/zotonic/.bashrc
echo "export ZOTONIC_SSL_PORT=443" >> /home/zotonic/.bashrc
setcap 'cap_net_bind_service=+ep' /usr/local/erlang/erts-7.2/bin/beam
setcap 'cap_net_bind_service=+ep' /usr/local/erlang/erts-7.2/bin/beam.smp
```
- echo "HOST_IP_ADDR    SiteName" >> /etc/hosts
- Postgres Zotonic DB tweaks
```
su postgres 
psql 
CREATE USER zotonic WITH PASSWORD 'zotonic'; 
ALTER USER zotonic CREATEDB; 

CREATE DATABASE zotonic WITH OWNER = zotonic ENCODING = 'UTF8'; 
GRANT ALL ON DATABASE zotonic TO zotonic; 
\c zotonic 
CREATE LANGUAGE "plpgsql"; 
exit
\q
exit
```
- Add WebSite
```
su zotonic 
zotonic start
/home/zotonic/zotonic/bin/zotonic addsite -s blog phiz 
vi /home/zotonic/zotonic/user/sites/phiz/config 
=====
Change SiteName, Port (8000 --> 80) and DB PASSWORD 
======
make 
```
- Force SSL (set mod_ssl vars)
```
mod_ssl    listen_port    443 
mod_ssl    is_ssl    true 
mod_ssl    is_secure    true 
```
```
zotonic modules -s phiz activate mod_ssl_self_signed
```
- Letsencrypt SSL (should be done as root, 443 port should be opened for check from letsencrypt side)

`certbot certonly --standalone -d your_domain_name.com`

if fails check if all -devel libs are installed (like puthon2-devel)
and `pip install cryptography --force-reinstall` after that

```
cp /etc/letsencrypt/live/`hostname -f`/fullchain.pem /home/zotonic/zotonic/user/sites/phiz/ssl/phiz.ca.crt
cp /etc/letsencrypt/live/`hostname -f`/cert.pem /home/zotonic/zotonic/user/sites/phiz/ssl/phiz.crt
openssl rsa -in /etc/letsencrypt/live/`hostname -f`/privkey.pem -out /home/zotonic/zotonic/user/sites/phiz/ssl/phiz.pem
```

## Install mod_kazoo
```
su zotonic
cd ~/zotonic/user/modules/
git clone https://github.com/onnet/mod_kazoo.git
zotonic shell
> z:m().
> z_module_manager:activate(mod_kazoo, z:c(phiz)).
```
### Upload initial keys to Zotonic DB (could be also configured through Zotonic admin portal)

vi mod_kazoo_initial_keys.csv
```
mod_kazoo       page_header     OnNet Innovations Limited
mod_kazoo       sender_name     OnNet Innovations Limited
mod_kazoo       user_agent_string       OnNet WebRTC Agent
mod_kazoo       default_kazoo_timezone  Europe/London
mod_kazoo       signup_service_plan     signup_plan
mod_kazoo       sales_email     iam@onnet.info
mod_kazoo       crm_email       iam@onnet.info
mod_kazoo       default_country         RU
mod_kazoo       default_kazoo_language  en-us
mod_kazoo       local_currency_sign     £
mod_kazoo       placeholder_phone       10123456789
mod_kazoo       callingcards_number     (xxx) xxx-xx-0xx
mod_kazoo       callback_number         (xxx) xxx-xx-xx
mod_kazoo       rates_file      /home/zotonic/zotonic/user/modules/mod_kazoo/files/unhandled/rates.txt
mod_kazoo       color1  #3DADE7
mod_kazoo       color3  #ffffff
mod_kazoo       color4  #C3C2C2
mod_kazoo       color2  #ee1212
mod_kazoo       kazoo_version   4.00
mod_kazoo       kazoo_super_duper_api_key       f2c66____change___me____ba2d2ca8
mod_kazoo       g_capture_secret        f2c66____change___me____ba2d2ca8
mod_kazoo       g_capture_site_key      f2c66____change___me____ba2d2ca8
mod_kazoo       wss_port                5065
mod_kazoo       kazoo_default_realm     .sip3.onnet.su
mod_kazoo       sip_registrar           sip3.onnet.su
mod_kazoo       kazoo_crossbar_url      https://kz527.onnet.su:8443
mod_kazoo       kazoo_portal_url        https://beta.onnet.info
mod_kazoo       kazoo_blackhole_url     wss://kz527.onnet.su:7777
mod_kazoo       show_finance_info               true
mod_kazoo       payments_list_widget_opened     true
mod_kazoo       numbers_list_widget_opened      true
mod_kazoo       current_services_widget_opened  true
mod_kazoo       contacts_widget_opened          true
mod_kazoo       user_settings_widget_opened     true
mod_kazoo       send_fax_widget_opened          true
mod_kazoo       signup_enabled                  false
```
- tab should be used as delimeter, for check use: sed -i 's/ \+ /\t/g'  mod_kazoo_initial_keys.csv    
- psql
- zotonic=> \copy config (module,key,value) from '~/mod_kazoo_initial_keys.csv';


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
