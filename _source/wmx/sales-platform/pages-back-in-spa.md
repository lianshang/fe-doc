# 销售端中反映出的单页应用回退问题思考

### 问题思考

---


> 单页面应用，顾名思义指页面不进行重新渲染，只发生视图间切换的web应用(更详细的解释大家可以自己查一下，可能说法不准确)    
> 这里就反映出了一个问题：页面不发生切换就 **无法使用浏览器自带的history** 页面回退系统；同时 **浏览器视图间的回退和逻辑回退往往存在差异** ，所以也不能使用 **history.go(-1)** 这样形式的回退方式；以及可能存在 **同一页面有多个进入入口，回退时需要进行逻辑判断** 的情况，因此导致回退问题更为棘手。

针对以上情况思考解决方式时需要解决的问题有：

> * 能够区分逻辑层面的上一级页面是什么，而不是简单地将页面切换为前一个页面
> * 在视图切换的过程中可以持续的进行保存和使用，不会因为页面的 **刷新** 而导致回退功能的失效
> * 如何实现回退功能，能否充分利用backbone自带的路由功能

上一次解决该问题还遗留的问题与近期思考发现的问题有：

> * 第一次解决时没有思考页面刷新导致存储在conf中的数据失效的问题(后来进行了优化，将完整路径保存在了localStorage中，避免刷新数据丢失)
> * 优化后将数据存储在localStorage中没有考虑应该在何时进行数据清除的问题(最近在熟悉代码过程中发现了localStorage中存储了大量的路径信息)
> * 如何合理的选取需要的属性参数问题，是否有存储完整路径的必要？
> * 如果设置为只保存必要的信息如何设置默认值的问题？(这样可以解决部分因长时间未登录导致用户登录session失效，但登陆后返回的页面可能需要相关回退的问题)

### 备选解决方案

---

* 方案一
	* 将所有参数都一直带着，一直保存在url中
		* 分析：使用这样的方式弊端很大。一是导致url越来越长，在何时进行清空参数是个问题；二是很多视图使用了相同的参数名(比如uid)，但是使用的值不同，这就导致在向后端请求时容易发生错误，所以这样的方式不可取，风险性很大。
		* 该方式日后 **不可使用**

* 方案二
	* 将所有浏览记录url都保存到localStroage中
		* 分析：这样的方式可以实现相关功能，在早前解决这一问题时也使用了这样的方式。**但是** 这种形式存在两个问题：1.url长度相对较长，持续存储占据了较大的本地存储空间；2.该在何时清空本地存储信息？第一个问题如果是考虑url长度问题这个无法解决，而占据存储空间大小问题可以通过问题二的解决方式来解决，应当在新切换到一个nav的时候清空存储信息(例如从*我的超市*到*未注册超市*)，**因为** 两个模块间本身不存在回退关系，在进入另一个的时候就断绝了会退到上一个页面的可能
		* 该方式日后 **尽量不用**，因为相对后续方案来说还是存在明显缺陷的，但是由于在回退实现上可以只修改router中的pageRollBack函数，只要生命正确回退关系即可，因此也有一定可取之处


*	方案三
	* 与后端提前约定好新视图返回需要的参数，在切换到新视图请求数据时一并返回部分所需参数
		* 分析：这种实现方式比较复杂，因为同时需要前后端联动，影响了现有返回数据的数据结构；但是使用起来比较方便，如果在新项目开始初期约定时可以考虑这种实现形式，**但是** 一旦出现用户刷新页面或间隔较长时间后再次进入页面的情况，后端就无法判断用户是从哪里进入的页面，所以存在局限性(我认为这种情况可以使用默认值来委曲求全保障功能完整)
		* 该方式日后 **可以考虑**，但易用性不高

* 方案四
	* 方案四综合了方案二、三的部分优点，将页面回退的参数抽出存储在了localStroage中
		* 分析：这种方式的优点在于：存储内容少，实现简单效果好
		* 本次解决方式选择了方案四进行，日后如果遇到相关问题可提供参考

### 实际操作步骤

---

#### 借助router中getQuery方法将页面切换时传递的参数存储起来


```
    getQuery: function (queryString) {
        var that = this;
        var querys;
        if(queryString) {
            querys = helper.queryLocationSearch('?'+queryString);   //模拟成query串
            console.log(querys);
            var backOpt = JSON.parse(localStorage.getItem('backOpt')) || {};
            for(var key in querys){
                if(querys.hasOwnProperty(key)){
                    backOpt[key] = querys[key] || null;
                }
            }
            localStorage.setItem('backOpt',JSON.stringify(backOpt));
            console.log(backOpt);

        } else {
            querys = {};
            localStorage.setItem('backOpt',JSON.stringify({}));
        }
        that.query = querys;
        return querys;
    },
```

这里将获取的每一个参数都存储到了localStroage的 **backOpt** 属性中，同时这里用 **hasOwnProperty** 方法判断了一下自有属性，同时如果新进入到一个nav模块时将其重置为 **{}** 空对象，实现了清空。

#### 需要回退时从backOpt中取出相关参数

举个unregistered->nearby视图使用的例子(这个例子涉及的特殊情况比较多)

```
    actionBack: function (e) {
        e.stopPropagation();
        var backOpt = JSON.parse(localStorage.getItem('backOpt'));
        var date_begin = backOpt.date_begin || '';
        var date_end = backOpt.date_end || '';
        var sort_by = backOpt.sort_by || '';
        var rid = backOpt.rid ? 0 : '';
        var uid = backOpt.uid ? 0 : '';
        if(backOpt.nearfrom == 1 ){
        app.navigate("unregistered/countlist?date_begin=" + date_begin + '&date_end='+ date_end + '&sort_by=' + sort_by + '&uid='+uid + '&rid='+rid, {trigger: true, replace: false});
        }else{
            app.navigate("unregistered/marketlist?date_begin=" + date_begin + "&date_end=" + date_end + "&uid=" + uid + "&rid=" + rid, { trigger: true, replace: false });
        }
    },
```

这里进行一下说明：

*	backOpt参数是存储在localStroage中在回退时可能用到的参数，这个页面用到的参数有date_begin(开始时间)、date_end(结束时间)、sort_by(筛选方式，有按销售和按地区两种，只有countlist页面用到)、rid(区域代码)和uid(用户代码)
* nearfrom参数是在调整回退时为了 **获取逻辑上的上级页面** 而单独设置的(用到了这一方式的还有mymarket中visitplan转到marketinfo页面时添加的planfrom参数)，通过判断这一参数来明确 **到底是从哪切换到这个页面的**
* `var rid = backOpt.rid ? 0 : '';`这句的出现是因为这一视图和要回退的上一视图都有rid(或uid)这一参数，但两者的参数不相同，因此通过判断本页面是否有这一参数来进行设置，实现了对 **同名参数的处理**
* 进行完上述步骤后即可实现回退功能

### 测试

---

测试分一下几种情况：

> * 正常使用
> * 出现页面刷新
> * 清空缓存数据(这里使用了 **localStroage.clear()** 来进行模拟)

对以上情况进行测试后，均暂未发现问题，可以正常回退并实现相关的功能(如标签选中、时间选中等)，筛选结果正常

### 结论

---

我认为这次使用的回退解决方案可以投入到项目中，但仍存在下列问题：


> 需要针对每一个具备回退功能的视图进行单独分析，暂未抽出合理的通用化组件，这点内容有待提升


个人认为这次问题解决方案较前几次(如H5自动化工具)方案准备来说有一定程度的进步和完善，希望大家能多提意见。
