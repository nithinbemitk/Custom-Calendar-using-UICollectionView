//
//  ViewController.m
//  CustomCalender
//
//  Created by Nithin.k on 18/05/17.
//  Copyright © 2017 NK dreams. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // Set your year and month here
    [components setYear:2018];
    [components setMonth:5];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range1 = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    //NSLog(@"days in month ---> %d", (int)range1.length);
    
    
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:18];
    [comps setMonth:5];
    [comps setYear:2017];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date567 = [gregorian dateFromComponents:comps];
    
    
    //NSDate *now = [NSDate date];
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    //NSLog(@"The day of the week is:-->  %@", [weekday stringFromDate:date567]);
    
 
    NSDate *now123 = [NSDate date];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [calendar123 components:NSWeekdayCalendarUnit | NSHourCalendarUnit fromDate:now123];
    NSInteger weekday123 = [dateComponents weekday];
    */
 
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
