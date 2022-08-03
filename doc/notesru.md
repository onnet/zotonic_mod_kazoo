# Ниструкция по установке OKUI (CentOS 7 Zotonic + mod_kazoo)
### Note: Для корректной работы OKUI необходимо заранее установить приложение [Onbill](https://github.com/onnet/onbill "onbill") в вашей телекоммуникационнй платформе Kazoo
## Установка Zotonic

- Отключите selinux.
- Добавьте следующие пакеты в вашей ОС CentOS 7:

```
yum -y install epel-release
yum -y install ImageMagick make vim git gcc gcc-c++ shorewall ntp inotify-tools libtiff-tools patch wxGTK python-setuptools libffi-devel openssl-devel python-devel certbot libxslt-devel zip unzip expat zlib-devel curl ncurses-devel git-core htmldoc gcc gcc-c++ openssl-devel expat-devel perl-Image-ExifTool mlocate

yum -y install  https://downloads.wkhtmltopdf.org/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm

echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
ln -fs /usr/share/zoneinfo/UTC /etc/localtime
timedatectl set-ntp true
```
- Установите Erlang
```
curl -O https://raw.githubusercontent.com/yrashk/kerl/master/kerl
chmod a+x kerl
mv kerl /usr/bin
kerl list releases
kerl build 19.3 r19.3
kerl install r19.3 /usr/local/erlang
```

- Подготовка системы
```
useradd zotonic 
echo "sleep 10" >> /etc/rc.local 
echo 'su - zotonic -c "nohup /home/zotonic/zotonic/bin/zotonic start &"' >> /etc/rc.local 
chmod a+x /etc/rc.local
systemctl enable rc-local
echo "`hostname --ip-address`    `hostname -f`    `hostname -s`" >> /etc/hosts
echo "export ZOTONIC_PORT=80" >> /home/zotonic/.bashrc
echo "export ZOTONIC_SSL_PORT=443" >> /home/zotonic/.bashrc
echo "export ZOTONIC_LISTEN_PORT=80" >> /home/zotonic/.bashrc
echo "export ZOTONIC_SSL_LISTEN_PORT=443" >> /home/zotonic/.bashrc
setcap 'cap_net_bind_service=+ep' /usr/local/erlang/erts-8.3/bin/beam
setcap 'cap_net_bind_service=+ep' /usr/local/erlang/erts-8.3/bin/beam.smp
```

- Установка Zotonic
```
su - zotonic 

vi ~/.bash_profile
======
PATH=$PATH:$HOME/zotonic/bin
export PATH
=====

vi .bashrc
. /usr/local/erlang/activate

cd /home/zotonic/ 

git clone git://github.com/zotonic/zotonic.git 
cd /home/zotonic/zotonic 

mkdir -p ~/zotonic/user/sites
cd ~/zotonic/user/sites
git clone https://github.com/onnet/phiz.git

mkdir -p ~/zotonic/user/modules
cd ~/zotonic/user/modules
git clone https://github.com/onnet/mod_kazoo.git zotonic_mod_kazoo
git clone https://github.com/onnet/mod_bt.git zotonic_mod_bt

vi ~/zotonic/user/sites/phiz/priv/config.d/vars #(adjust site variables)

. /usr/local/erlang/activate
cd ~/zotonic
make 
zotonic debug # (or zotonic start)

```



