> MVC

## 1、MVC简介

> MVC是一种框架，不是设计模式。

* M：`Model`，只负责对数据处理，实现具体的业务逻辑
* V：`View`，负责界面的展示，展示数据。如：按钮、列表、图片
* C：`Control`，负责将在View上的操作传给Model，将Model处理过的数据在View上显示出来


## 2、MVC交互

iOS中的MVC交互如上图所示：

![pic](http://7mj4a6.com1.z0.glb.clouddn.com/jj.png)

### MC交互

iOS中，`Controller`直接向`Model`请求数据。一般Model的类作为控制器的属性，调用model里相应的方法即可；Model在数据变化时可以通过Notification或KVO来告知Controller.

### VC交互

C可以直接操作`View`。在`storyBoard`中，拖拽View上的控件，通过outlet实现对View的操作；纯代码时，通过实例化空间，对View进行操作。由于View不处理事件，不知道用户操作后，Controller会做什么，所以通过将Controller设置为View的`DateSource`和`delegate`，通过设置这些，使控制器响应事件，更新View。

### MV交互

M和V不能直接通信，只能通过C通信


## 3、使用MVC的好处：

### 1、C代码减少，易于维护

进行拆分后，Controller中只负责在Model和View层传递数据、响应视图的点击事件，所有的与显示相关的控件放在View中，数据处理存放到Model中，使视图和控制器之间复杂冗余的代码，为控制器瘦身，MVC代码独立，易于维护，比如在后期版本迭代中，想要修改一些View显示，而数据逻辑处理不变，只需要对View上的控件设置即可。

### 2、提高复用性

应用中不同模块从网络上请求的不同的数据会使用相同的Model，提高复用性。

### 3、代码结构清晰，让人容易理解

当View层的操作使数据发生变化时，Controller只需将要处理的Model数据传给Model，让Model处理完成后，返回给Controller一个处理好的数组,显示在View上即可。至于数据是怎么处理的，去Model里查看即可。
