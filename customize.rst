站点自定义
==========

CSS定制
-------

插件
----

修改 ``container/app.yml`` 以安装插件::

   hooks:
   after_code:
     - exec:
         cd: $home/plugins
         cmd:
           - git clone https://github.com/discourse/docker_manager.git
           - git clone https://github.com/discourse/discourse-spoiler-alert.git  # 防剧透 (?)
           - git clone https://github.com/discourse/discourse-math.git           # MathJax 数学支持

然后 rebuild. 要使插件启用还需要在网站设置中开启, 然后等待一段时间以使设置生效.

可能有用的插件:

* 数学插件 `Math Plugin <https://meta.discourse.org/t/discourse-math-plugin/65770>`_ (支持 MathJax 和 KaTeX)
* 清单列表 `Checklist <https://github.com/discourse/discourse-checklist>`_

定制组件
--------

在设置标签中

* `Kanban theme <https://theme-creator.discourse.org/theme/david/kanban>`_
* `Category Banners <https://meta.discourse.org/t/discourse-category-banners/86241>`_
* `Disco TOC - automatic table of contents <https://meta.discourse.org/t/discourse-category-banners/86241>`_

页脚文字
--------
自定义页脚需要在主题中设置. 以向 default 主题添加备案号为例, 编辑 CSS/HTML, 通用-页脚, 插入下列代码

   <div style="text-align: center; color: #999; font-size: 90%; padding: 2em 0;">
     Copyright &copy; 2021 CCME-TMC. <a href="https://beian.miit.gov.cn/">苏ICP备2021043781号-1</a>
   </div>

此外, 默认不在登录页面显示页脚内容, 因此当论坛为私有时, 外部审查无法看到页脚备案号.
要在登录页面上显示页脚, 可添加主题组件 `Easy responsive footer <https://github.com/discourse/Discourse-easy-footer>`_.
在设置中删去所有无关内容, 仅打开 Show footer on login required page 开关即可. 退出登录检查是否显示页脚.
