## 基于流处理和NLP的Emacs编辑器: EmacsSparkNLP, 只要编辑代码的`数据源头`,其他的自动编辑都是它变化的映射编辑 & 学习历史搜索,排序和输入信息等进行NLP向量化, 实现智能搜索和推荐列表等

*自我设计思想,Lisp第一原理裸奔的速度 => 复用的极限(封装纯函数库和Emacs自动化编辑函数库) = 复利*

* 运用运行时的cider来Postwalk修改代码本身(专门弄一个clojure前后端库[postwalk-editer](https://github.com/chanshunli/emacs_spark/tree/master/postwalk-editer)来支持流式编辑)
* Yasnippet和Postwalk和Instraparser和Datalog(postwalk-editer集成datomic来支持)三者相结合,用于分析代码修改代码: [Using Datalog with Binary Decision Diagrams for Program Analysis](https://people.csail.mit.edu/mcarbin/papers/aplas05.pdf)
* 记录Lisp Repl的历史,通过历史的代码来训练帮助补全代码: 通过datalog来实现代码的历史查询,路径查询等
* 融合代码语义搜索和EmacsSpark(天天在用,无时不刻都在用的东西,才能真正的看到它的缺点,改进它)
* 流式响应编辑的速度(编辑源头的数据,所有的都变成编辑的算子去流式的编辑) VS Lispy式的快速移动选中的速度
* 所有的代码都是分布式表示存储的,可以从数据库里面快速取出来代码,合成现在你需要的代码
* 所有的代码都是可以在高维空间中多分类出来的
* 代码模式的识别和模式归纳,用不可变的代码部分或者用的次数最多的部分作为代码生成器核心部分
* 计算代码和计算论文的思想统一, 代码本身也是可计算的一部分, 就像数据表一样统计学计算
* [postwalk-editer](https://github.com/chanshunli/emacs_spark/tree/master/postwalk-editer)集成libpython-clj,使用NLP来辅助代码自动化编辑和代码模式学习, 还有机器翻译模型Seq2Seq辅助你生成代码注释
