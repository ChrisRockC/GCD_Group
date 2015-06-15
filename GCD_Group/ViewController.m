//
//  ViewController.m
//  GCD_Group
//
//  Created by mac on 15/6/16.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


/**
 $ man dispatch_group_enter
 GCD很多最完整的帮助是在终端里面，而不是在联机文档里面
 
 注意：enter & leave 是要成队出现的
 
The dispatch_group_async() convenience function behaves like so:

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
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建一个群组
    dispatch_group_t group = dispatch_group_create();
    
    //2.获得去全局队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    //3. 异步任务
    //3.1 群组进入，监听后续的异步方法的执行
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"1-------%@",[NSThread currentThread]);
        
        //3.2 block最后一句，宣布任务完成，群组取消对异步方法的监听
        dispatch_group_leave(group);
    });
    
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"2-------%@",[NSThread currentThread]);

        dispatch_group_leave(group);
    });

    
    //4.监听任务执行完毕只后回到主线程
    dispatch_group_notify(group, q, ^{
        NSLog(@"完成回调  %@",[NSThread currentThread]);
    });

}


//GCD群组
-(void)groupDemo
{
    
    //1.创建一个群组
    dispatch_group_t group = dispatch_group_create();
    
    //2.获得去全局队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    //3. 异步任务
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    
    //4.监听任务执行完毕只后回到主线程
    dispatch_group_notify(group, q, ^{
        NSLog(@"完成回调  %@",[NSThread currentThread]);
    });

}
@end
