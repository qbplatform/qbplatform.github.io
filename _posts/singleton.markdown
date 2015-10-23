---
layout: post
title: "设计模式——单例模式（Singleton)"
categories:[java,设计模式]
date: 2015-10-23
auther: 刘纯
---

###描述
单例模式（Singleton）是指该类有且仅有一个实例，该模式分为懒汉式和饿汉式。

---

### 饿汉式
它是指在定义变量的时便给它分空间（即代码中：private static Singleton4 unqueInstance=new Singleton4())，将它实例化。

java代码如下：

    public class Singleton4 {  
        private static Singleton4 unqueInstance = new Singleton4();  
        private Singleton4(){  
              
        }  
        public static Singleton4 getInstance4(){  
            return unqueInstance;  
        }  
    } 
---
###懒汉模式
它指在定义变量的时候不分配空间，而是在使用的时候才实例化。

java代码如下：

    public class Singleton1 {  
        private static Singleton1 unqueInstance;  
        private Singleton1(){  
          
        }  
        public static Singleton1 getInstance(){  
            if(unqueInstance==null){  
                unqueInstance=new Singleton1();  
            }  
            return unqueInstance;  
        } 
    }
这种情况表面上看似乎没什么问题，但是多线程的情况下就存在很大问题，并不能保证只产生一个实例。比如现在有两个线程thread1,thread2执行getInstance()方法，一般情况每个时刻只有一个线程在执行，假设执行顺序如下：1、thread1执行if(unqueInstance==null)  2、thread2执行if(unqueInstance==null) 此时两个线程都会创建一个实例，从而导致多个实例；当然，也存在解决方案，下面讨论几种解决方案。

####方案一
为方法加关键字synchronized,可以解决多线程的问题
java代码如下：

    public class Singleton2 {       
        private static Singleton2 unqueInstance;  
        private Singleton2(){  
              
        }  
        public static synchronized Singleton2 getInstance(){  
            if(unqueInstance==null){  
                unqueInstance=new Singleton2();  
            }  
            return unqueInstance;  
        }  
    }  
####方案二
采用“双重检查加锁”
java代码如下：

    public class Singleton3 {  
        private volatile static Singleton3 uniqueInstance;  
        private Singleton3(){  
              
        }  
          
        public static Singleton3 getInstance(){  
            if(uniqueInstance==null){  
                synchronized(Singleton3.class){  
                    if(uniqueInstance==null){  
                        uniqueInstance=new Singleton3();  
                    }  
                }  
            }  
            return uniqueInstance;  
        }  
      
    }  

这两种方案中显然第二种方案更优，因为它只有在第一次创建实例的时候才会进入synchronized区，而方案一在每次调用getInstance()方法的时候都必须判断是否有其它线程在调用此方法。
