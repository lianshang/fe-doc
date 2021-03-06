# 分支开发流程

项目代码保存在`github`上，本地所使用的版本管理工具是`git`。

代码的主要分支有`master`，`dev`两个，`master`作为上线后最稳定，最新的代码版本，`dev`作为准上线分支，这两个是常驻分支。除了上线，这两个分支不做使用。

每次进行开发时，都应从`dev`上开辟新的功能分支，比如分支`newbranch`。在 `newbranch`上进行功能的开发，调试。

### 步骤：

1. 开发前明确需求，需求定下来之前会有“需求评审会议”，所有参与本次开发的人员均要出席，一起讨论需求的合理性，解答开发中可能遇到的疑问。

* 需求明确后，先评估工作量，给出自己的排期，这个时候只要考虑自己的开发时间就好，一定要合理，有必要要留出`buffer`（缓冲时间），后端给出排期，测试人员给出排期，PM给出提测时间和上线时间。

* 进行开发，首先本地切换至`dev`分支，使本地`dev`分支和线上代码同步，执行命令：

      git pull

* 更新本地dev分支后，新建分支，用于新需求的开发，执行

      git checkout -b newbranch

  或者

      git branch newbranch；

* 现在可以在`newbranch`上进行开发了，开发过程中每次提交到远程，都要确认不会影响到其他分支，主要是为了防止`push`到其他分支。开发过程中可以不做`newbranch`的任何更新（不合并任何分支），最后开发完毕后一起`merge dev`。开发过程中进行自测。

* 本次需求开发完成后，需要将`newbranch`更新至最新，切换至本地`dev`分支：

      git checkout dev

* 此时需要更新本地的dev分支，使其与线上代码同步，首先先确认远程dev分支当前是与线上同步的最新代码，执行命令：

      git pull

* 上一步完成，目前本地dev分支为最新，然后要将最新的代码dev与自己开发的功能分支newbranch合并，为确保合并过程中没有冲突，最好先将dev的代码合并到newbranch上，切换至newbranch分支，执行命令：

      git checkout newbranch

* 将dev合并到new branch上，在newbranch上执行命令：

      git merge dev

* 上一步执行完可能会有冲突，原因是更新的内容和本次开发的内容在同一个位置（同一文件同一行），此时需要手动打开那些冲突文件，进行代码的合并，判断哪些代码是要保留的，哪些是需要删除的。

* 更新newbranch完成后，需要再次测试一下，自己开发的功能是否可以使用，对以前的功能是否有影响，没有问题后，可以进行提测。

* 首先切换至本地dev分支，将newbranch分支合并到dev分支（理论上此时不应该存在代码冲突），执行命令：

      git merge newbranch

* dev合并无误后，准备推到测试环境（qa），交给测试人员测试，再次之前需要群里发声明，请求占用qa（测试）环境，这是为了防止有人在使用测试环境，如果贸然发布项目到qa环境，很容易就影响了别人的测试。当允许占用测试环境的时候，再将dev推到qa环境测试。

* 推到qa环境后，前端，后端，PM，测试人员进行测试，也就是提测，此时如果有较小的改动的话，可以再dev分支上进行修改。

* 测试无误后，将dev推送到远程dev分支：

      git push origin dev

* 上线。

* 上线后代码回归，所有参与开发人员确认线上无误。

* 当确认不再进行更改，dev不再改动时，合并master分支，先切换至本地master分支：

      git checkout master

* 切换后，master合并分支dev：

      git merge dev

* 合并成功后，将master推到远程：

      git push

此次开发结束，在不需要的情况下，可以选择删除功能分支`newbranch`了。

如果对上面流程不清晰，可以参照下面附件中的流程图。

![分支开发流程图](http://7mj4a6.com1.z0.glb.clouddn.com/2016040104312612.png)
