# Newbee English



## Description

**Newbee-English 英语学习平台** 的 repo。本 repo 成员一致反内卷，因此本仓库所有代码 **全部开源**。



###### 各个小组代码仓库：

| 小组                | 仓库地址                                                     |
| ------------------- | ------------------------------------------------------------ |
| Main                | [SnapdragonLee/Newbee-English (github.com)](https://github.com/SnapdragonLee/Newbee-English) |
| Backend             | [SnapdragonLee/Newbee-backend (github.com)](https://github.com/SnapdragonLee/Newbee-backend) |
| Frontend            | [zrjzrj0403/Newbee-Frontend (github.com)](https://github.com/zrjzrj0403/Newbee-Frontend) |
| Weixin Mini Program | [edwardyangjh/miniprogram_Newbee English (gitee.com)](https://gitee.com/edwardyangjh/newbee-english) |



###### IDE

本仓库 Backend/ Frontend 小组 IDE 使用 **Jetbrains 系列**，Weixin Mini Program 使用微信提供的开发者工具。



###### 部署方式：

小组子仓库在主仓库根目录下，使用 **submodule** 进行引用。在提交时首先在子仓库目录下进行提交，再在主目录下进行提交，确保不会出现意外。当克隆整个项目的时候，只需要克隆主仓库，即可获得所有端代码，方便调试、运行。



下面举个例子：例子中的主仓库目录为 `./`，子仓库目录为 `./backend/` 等。

1. 如何克隆本仓库的所有代码：注意在使用 `git clone` 命令时加入 `--recursive` 参数。

   ```bash
   git clone --recursive https://github.com/SnapdragonLee/Newbee-English.git
   ```

   如果在 `./backend` 下看见文件，则克隆成功。

   

2. 如何在 **已经创建本项目的情况下** 拉取代码：

   ① 在主仓库根目录下可进行 **拉取所有子仓库代码** 操作，但要注意多加了一条指令：

   ```bash
   git pull
   git submodule update --init --recursive
   ```

   第一条指令，拉取主仓库的所有代码；第二条指令。拉取所有的子仓库代码（每次都要使用）。

   ② 先进入小组目录，再进行 `git pull` 操作（请不要在克隆失败的情况下使用这个操作，且这个操作会拉取最新的代码，而不一定是稳定的）。

   

3. **如何进行一次标准提交**：

   当你对所在小组的代码进行了改动过后，**且你认为已经完成了 / 优化了相应的功能时**，这个时候需要在主仓库进行提交，更新你的子仓库代码；而对于平常写代码时你认为没有完成某一功能/某一功能还存在肉眼可见的问题时，只需要在子仓库中进行提交即可。（主仓库中对子仓库的引用是“指针式“，即指向子仓库特定的 commit 版本，因此请保证最稳定/bug最少的版本提交到主仓库中）

   ① 例如在后端子仓库代码中进行了改动，增加了授权信息录入功能，请首先进入后端组代码目录。

   ```bash
   cd backend
   git status
   git add {}
   git commit -m "xxx"
   git push [origin {master}]
   ```

   在该目录下进行更改，commit 操作之后，push 到后端子仓库 https://github.com/SnapdragonLee/Newbee-Backend.git 。

   ② 回到根目录

   ```bash
   cd ..
   git status
   git add {}
   git commit -m "update submodule xxx"
   git push [origin {master}]
   ```

   再次进行 commit 操作，内容最好与 submodule 相关，最后 push 到主仓库 https://github.com/SnapdragonLee/Newbee-English.git 。

   

   **\*已知异常错误：如果主仓库无法检测到子仓库的更改，即 git status 命令后显示没有任何更改，此时查看进程 kill 掉 Git 的所有进程，再次 git status 即可看到更改。**

   

   **\*注意，这个过程遇到的任何问题，请先快速查阅 [Git - 子模块 (git-scm.com)](https://git-scm.com/book/zh/v2/Git-工具-子模块)，解决不了的提交 issue。**

   

4. 如何 **添加** 新的子仓库引用：有的小组子仓库还没有创建，创建了之后如何加入到主仓库的引用中呢？

   ① 在子仓库目录下进行提交，push 到子仓库。不要直接在主仓库中进行提交，

   ② 回到主仓库，例如需要添加的子仓库引用地址是 https://github.com/SnapdragonLee/Newbee-backend ，则使用命令：

   ```
   git submodule add https://github.com/SnapdragonLee/Newbee-backend
   ```

   这个时候就可以发现在主仓库目录下的 `.gitmodules` 中出现了相关的子仓库引用配置。

   ③ 同 “3. 中的 ②” 进行正常的 commit 操作后，push 到主仓库即可。

   

###### 文件目录格式：

请将本仓库文件目录按如下方式部署：

```
.
├── .git
│   ├── ...
├── backend
│   ├── .git
│   │   ├── ...
│   ├── LICENSE
│   ├── ...
│   └── README.md
├── ...
├── docs
│   ├── Requirements
│   │   ├── assets
│   │   │   ├── ...
│   │   │   └── 总体框架.png
│   │   ├── ...
│   │   └── Requirements.pdf
│   └── Weekly
│       └── ...
├── LICENSE
├── .gitignore
├── .gitmodules
├── Newbee English.png
└── README.md
```





## Group Members

徐乐陶 李霄龙 姜田龙 杨佳豪 张昊雨 赵润晶 李肇嘉



<div align=center>
	<img src="Newbee English.png">
</div>

<div align = "center"> P1 - Newbee English LOGO</div>
