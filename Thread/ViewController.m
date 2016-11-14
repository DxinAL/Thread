//
//  ViewController.m
//  Thread
//
//  Created by D.xin on 2016/11/14.
//  Copyright © 2016年 D.xin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //线程   线程的三种操作方式   都有神马不同之处   ，NSOptionqueue是GCD的面向对象形式。
    /*
     1  GCD 是底层的C语言构成的API，而NSoperationQueue 以及相关是对象  。在GCD中我们在队列中执行的是block中的任务，而在NSOperationqueue为我们提供了更多的选择
     
     2 在NSOperationQueue中我们可以随时取消要执行的任务，但是GCD中我们无法停止queue中的代码，（其实是有的但是需要更多复杂的代码）
     
     3 NSoperation可以方便的设置以来关系，这样可以让一个Operation依赖另一个operation，这样的话两个operation在同一个队列之中，但是前一个会在后一个执行完之后再执行
     
     4 KVO与NSoperation结合执行的话，会更好的监听后台任务的执行进度
     
     
     5 NSOperation中我们可以设置Operation的优先级，能够使一个对列中的任务分先后执行，但是在GCD中，我们只能分对列的优先级，但是不能分任务的优先级，如果要区分CGD 任务的 优先级就需要非常复杂的代码
     
     6 我们能够对NSOperation进行继承，在这之上添加成员变量与成员方法，提高整个代码的复用度
     */
    NSInvocationOperation *invovationOption = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocation) object:nil];
    //直接调用start 方法并不会开辟新的线程去执行任务，会在当前的线程执行任务
    [invovationOption start];
    
    NSBlockOperation *blockOption = [NSBlockOperation blockOperationWithBlock:^{
        
        //执行任务
    }];
    //同步执行
    [blockOption start];
    
    [blockOption addExecutionBlock:^{
      
        //这时候就会异步执行
    }];
    [blockOption addExecutionBlock:^{
       
        //异步执行
    }];
    
    
    
    
    
    
    //把NSOperation与operationQueue结合使用才可以发挥出巨大的威力
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //放到自主对列中的任务自动回异步执行  一旦被添加到队列中，就会异步执行
    [queue addOperation:invovationOption];
    [queue addOperation:blockOption];
    [queue addOperationWithBlock:^{
        
    }];
    //设置最大的并发数
    [queue setMaxConcurrentOperationCount:6];
    
    [invovationOption cancel];//结束某一个任务
    
    //结束一个队列中的任务，但是不能够结束正在执行的任务
    [queue cancelAllOperations];
    
    //添加以赖和监听 这意味着blockOption 会在invocationOption之后执行
    [blockOption addDependency:invovationOption];
    
   //监听一个任务的执行完毕之后我们可以执行一些操作
    blockOption.completionBlock = ^(void){
        NSLog(@"执行完毕");//这个操作还是在子线程中进行的但是跟被监听的线程不一定是在一个线程
    };

    
    
    
    
    
    
    
    
    
    
}

-(void)invocationOption{

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
