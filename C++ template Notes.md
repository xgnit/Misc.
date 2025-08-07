在c++14以后，有简写的方法。比如 typename std::decay<T>::type就成了std::decay_t<T>
std::is_same<T1, T2>::value 变成了std::is_same_v<T1, T2>。

注意后缀 `_t` 意味着返回值是一个type，`_v`的后缀意味着返回值是一个值(constexpr bool)。这个在标准库里都是通用的。
