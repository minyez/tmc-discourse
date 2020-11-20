个人站点尝试 2020-11-18
-----------------------

在自己注册的 Vultr 服务器 (CentOS 8.0 ) 上::

   git clone https://github.com/discourse/discourse_docker.git /var/discourse
   cd /var/discourse

然后在 `mailjet <https://app.mailjet.com/>`_ 上注册账户,
在 ``account/setup`` 页面上获取 SMTP 配置.

运行::

   ./discourse-setup

除了 RAM 空间不够外, 还报错

1. 未找到 ``netstat`` 命令. 
   CentOS 7 上默认不包括. 用 ``yum install net-tools`` 安装解决.
2. 能找到 ``docker`` 但是未找到 ``docker.io`` 命令. 
   使用官方的 repo 而不是 yum 上的 repo::

      yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
      yum install docker-ce docker-ce-cli containerd.io

   重新运行 ``discourse-setup`` 仍然没有找到 ``docker.io``, 但 docker 能正常拉取 ``discourse/base``.

在腾讯云上开了个新的域名 minyez.xyz, 新增记录值为 vultr VPS 的 IP, 主机名为 discourse.
重新运行 setup, 设置::

   Hostname for your Discourse? [discourse.example.com]: discourse.minyez.xyz
   Email address for admin account(s)?: stevezhang@pku.edu.cn
   SMTP server address? [in-v3.mailjet.com]: in-v3.mailjet.com
   SMTP port? [587]: 587
   SMTP user name? [reply@example.com]: <mailjet-API>
   SMTP password? [pa$$wd]: <mailjet-secret>
   Optional email address for Let's Encrypt warnings? (ENTER to skip) [me@example.com]:

等 10 min 左右安装. 安装成功后可成功到达注册页面. 用上面的 admin 账户邮箱注册, 但是邮箱并没有收到确认邮件.
用 telnet , 可以连接到 mailjet 的邮件服务器.

在 DNS 上添加 TXT 记录以信任域名仍无效. 根据参考资料修改 TLS 为 ``false``, 仍无法发送邮件.

在 mailjet 上新增子域名 ``@discourse.minyez.xyz``, 并在 DNSPod 上添加相应的 SPF/DKIM 认证.
执行 rebuild, 仍然不行.

换了一个 ubuntu 的 vultr VPS.

安装 Docker 时遇到错误 ``E: Package 'docker-ce' has no installation candidate``, 解决方案在 `SO <https://askubuntu.com/a/1082945>` 上::

   apt install apt-transport-https ca-certificates curl software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
   add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
   apt update
   apt upgrade

这个问题下有人说要把 bionic 换成 disco. 这里 bionic 在 20.10 中也是可以的. 然后跟上面 CentOS 一样安装::

   apt-get install docker-ce docker-ce-cli containerd.io

在 setup 后登录网站, 注册, pku 邮箱成功收到注册邮件! 先前出问题的可能是

1. CentOS 本身的问题
2. Discourse 与原 VPS 上的 SSR 存在一些端口冲突

追记: 直接拷贝 app.yml 到组内服务器, 然后 rebuild, 无法重现成功的安装 T_T 准备用 setup 重试一下.

端口转发暂时不会弄. 花 70 买了一个腾讯云的服务器, 用一个月看看效果.
