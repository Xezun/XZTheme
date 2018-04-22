主题样式配置说明
1. 以 # 开头的为主题名。
2. 以 . 开头的为样式名。
3. 样式名 A-Z、a-z、0-9、_、- 切不能以数字开头。
4. 复合样式以单个空格分隔。
5. 复合样式会自动继承所有属性，如 .main .header 会继承 .main 的属性。后期在考虑为属性设置默认继承规则。
6. 样式会包含子样式，字样式名以 . 开头，字样式名与控件属性对应，复合名称的字样式意思为多个属性有相同的样式，即子样式不存在复合样式，子样式默认不继承。
7. UIView 控件的样式为其自身样式与父视图样式并集。
    - 父视图 .main 子视图 .header 那么子视图样式为 .main .header
    - 父视图 .main 子视图 .header .bold 那么子视图样式为 .main .header | .main .bold -> .main .header.bold
    - 父视图 .main 子视图 .bold .header 那么子视图样式为 .main .bold | .main .header -> .main .bold.header


.a .b.c d 既能匹配 .a .b. d 也能匹配 .a .c .d 。

如果样式配置有 

.a { }
.a .b d {}
.a .c d {}

.a .b.c d {}

主题框架可能与 CSS 有类似之处，但是其设计目的不同。
配置文件初期只考虑 .plist 文件，后期再考虑是否支持类似 CSS 格式的文件。

!!! 准备以新的方式来实现。
1，暂时弃用使用配置文件的方案，比较维护配置文件也是一件困难的事。
2，采取类似 view.theme.day.normal.backgrondColor 来实现，但是其可能对于属性需要反复拓展，会造成同一个类的属性过多，使用起来可能并不方便。
3，采取 Theme.day.register(view, config(view)) 的方案，使用运行时的方法，提供一个对象供控件配置样式，这个对象将所有操作存储起来 NSInvocation 。

Theme.day.register
