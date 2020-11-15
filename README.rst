What is this repo for?
======================

这个仓库主要用作记录搭建课题组公共论坛过程中的设想, 以及学习应用相关技术时的笔记.
同时, GitHub 的 issue 功能也可以作为收集其他同学意见的窗口, 对想法和探讨进行追踪.

Target
======

当前的目标是基于 `Discourse <https://www.discourse.org/>` 应用的 Docker 容器,
搭建 `CCME-TMC <http://www.chem.pku.edu.cn/jianghgroup/>` 的公共讨论平台,
便于知识分享和问题探讨.

Ideas
=====

设想的架构::

   tmc.chem.pku.edu.cn
   |
   |- News : 课题组新闻, 通知等
   |
   |- Questions : 问题讨论
   |
   |- Journal Club : 文献推荐
   |
   |- Resources : 组会资料 (主持人上传), 资源推荐和分享 (外链)
   |

Motivatives
===========

Why Discourse?
--------------

#. 应用本身完全免费 **Free**;

#. 开源, 支持自主托管 Open-source and capable of self-host;

#. 拥有最新的论坛功能 Cutting-edge developed for forum;

#. 即使对非专业人员, 部署难度也较为友好 Friendly for non-expert to deploy by using Docker container.

Why not WeChat group?
---------------------

#. 微信群的讨论难以归结到特定主题下, 也难以搜索 Discussion are not under a specific topic and hard to do search;

#. 讨论记录备份困难 It is difficult to back up chat history;

#. 未下载文件会被过期清理 Files will be soon expired if not downloaded;

#. 容易模糊生活与工作之间的分界 The boundary between work and life can be obscured;

#. 总体而言微信还是面向即时通讯, 而非公共讨论 After all, WeChat is oriented to mobile OICQ, but not public discussion.

Resources
=========

* Docker 官方配置方案: https://github.com/discourse/discourse/blob/master/docs/INSTALL-cloud.md
* 国内资源
  * <记录一下部署Discourse论坛的过程>: https://www.orgleaf.com/3098.html
  * <开源论坛之discourse搭建>: https://www.imooc.com/article/282588/
  * <如何在 Ubuntu Linux 16.04上安装开源的 Discourse 论坛>: https://www.imooc.com/article/268043

Miscs
=====

一点个人私心: 利用这样的机会, 学习一下论坛的搭建, 为以后自己的研究工作做准备.

