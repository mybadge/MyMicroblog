//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//let a = (Double)(random() % 256) / 256.0

//for i in 0...40 {
//    //print((Double)(random() % 256) / 256.0)
//}

//UIColor(red: (CGFloat)(random() % 256) / 256.0, green: (CGFloat)(random() % 256) / 256.0, blue: (CGFloat)(random() % 256) / 256.0, alpha: 1)


//func gcd(var m: Int,var n: Int) -> Int{
//    while (m != 0 && n != 0) {
//        if m > n {
//            m = m % n
//            
//        } else {
//            n = n % m
//            //print(n)
//        }
//        print("m=\(m) n=\(n)")
//    }
//    return m == 0 ? n : m
//}

//gcd(136, n: 22)

var a = 8
var b = 5
//a = a + b
//b = a - b
//a = a - b
a = a^b
b = b^a
a = b^a


//冒泡排序代码
//
//static void Main(string[] args)
//{
//    ////五次比较
//    for (int i = 1; i <= 5; i++)
//    {
//        List<int> list = new List<int>();
//        //插入2k个随机数到数组中
//        for (int j = 0; j < 2000; j++)
//        {
//            Thread.Sleep(1);
//            list.Add(new Random((int)DateTime.Now.Ticks).Next(0, 100000));
//        }
//        Console.WriteLine("\n第" + i + "次比较：");
//        Stopwatch watch = new Stopwatch();
//        watch.Start();
//        var result = list.OrderBy(single => single).ToList();
//        watch.Stop();
//        Console.WriteLine("\n快速排序耗费时间：" + watch.ElapsedMilliseconds);
//        Console.WriteLine("输出前是十个数:" + string.Join(",", result.Take(10).ToList()));
//        watch.Start();
//        result = BubbleSort(list);
//        watch.Stop();
//        Console.WriteLine("\n冒泡排序耗费时间：" + watch.ElapsedMilliseconds);
//        Console.WriteLine("输出前是十个数:" + string.Join(",", result.Take(10).ToList()));
//        Console.ReadKey();
//    }
//    
//}

//冒泡排序算法
//private static List<int> BubbleSort(List<int> list)
// {
//    int temp;
//    for (int i = 0; i < list.Count - 1;i++ )
//    {
//        for (var j = list.Count-1; j > i;j-- )
//        {
//            if (list[j - 1] > list[j])
//            {
//                temp = list[j - 1];
//                list[j - 1] = list[j];
//                list[j] = temp;
//            }
//        }
//    }
//    return list;
//}

相对于简单选择排序，冒泡排序交换次数明显更多。它是通过不断地交换把最大的数冒出来。冒泡排序平均时间和最坏情况下（逆序）时间为o（n^2）。最佳情况下虽然不用交换，但比较的次数没有减少，时间复杂度仍为o（n^2）。此外冒泡排序是稳定的。