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

定制组件
--------

在设置标签中

* `Kanban theme <https://theme-creator.discourse.org/theme/david/kanban>`_
* `Category Banners <https://meta.discourse.org/t/discourse-category-banners/86241>`_
* `Disco TOC - automatic table of contents <https://meta.discourse.org/t/discourse-category-banners/86241>`_
