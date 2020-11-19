个人站点尝试 2020-11-18
-----------------------

在自己注册的 Vultr 服务器上::

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
可能的问题在于 mailjet 无法设置单独子域名的 trust, 只能是 ``any@minyez.xyz``.

准备换 SendGrid 作为邮件服务器再测试.

