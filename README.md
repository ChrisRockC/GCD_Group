# GCD_Group
群组进入
=================================== 

应用场景 
----------------------------------- 
当我们从事移动端开发，从服务器端获取网络数据之前，我们是无法知道此网络数据（例如图片）的大小。
并且这些操作都是耗时操作， 需异步执行完毕，将这些图片资源缓存到本地，我们才能在主线程进行相关的UI操作。

解决方案
----------------------------------- 
1. 异步方法，用SDWebImage 的Manager单例的下载图片方法，完成图片下载缓存
2.利用群组进入 监听异步操作，完成之后，回到主线程

Tip
----------------------------------- 
    1.$ man dispatch_group_enter
    GCD很多最完整的帮助是在终端里面，而不是在联机文档里面
    
    2.群组进入示例
    void
    dispatch_group_async(dispatch_group_t group, dispatch_queue_t queue, dispatch_block_t block)
    {
        dispatch_retain(group);
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            block();
            dispatch_group_leave(group);
            dispatch_release(group);
       });
    }
