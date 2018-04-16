主题样式配置说明
1. 以 # 开头的为主题名。
2. 以 . 开头的为样式名。
3. 样式名 A-Z、a-z、0-9、_、- 切不能以数字开头。
4. 复合样式以单个空格分隔。
5. 复合样式会自动继承所有属性，如 .main .header 会继承 .main 的属性。后期在考虑为属性设置默认继承规则。
6. 样式会包含字样式，字样式名以 . 开头，字样式名与控件属性对应，复合名称的字样式意思为多个属性有相同的样式，即字样式不存在复合样式，子样式默认不继承。
7. UIView 控件的样式为其自身样式与父视图样式并集。
    - 父视图 .main 子视图 .header 那么子视图样式为 .main .header
    - 父视图 .main 子视图 .header .bold 那么子视图样式为 .main .header | .main .bold -> .main .header.bold
    - 父视图 .main 子视图 .bold .header 那么子视图样式为 .main .bold | .main .header -> .main .bold.header


