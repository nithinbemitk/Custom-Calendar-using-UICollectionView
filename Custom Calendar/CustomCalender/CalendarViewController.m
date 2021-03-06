//
//  CalendarViewController.m
//  CustomCalender
//
//  Created by Nithin.k on 18/05/17.
//  Copyright © 2017 NK dreams. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCollectionViewCell.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    //        displayingYear = 2016;
    //        displayingMonth = 1;
    
    //    displayingYear = 2015;
    //    displayingMonth = 8;
    
    //        displayingYear = 2020;
    //        displayingMonth = 2;
    
    displayingYear = (int)[components year];
    displayingMonth = (int)[components month];
    
    
    
    numberOfDaysInMonth = [self toGetNumberOfDaysInMonth:displayingYear withMonth:displayingMonth];
    firstDayOfTheWeek = [self toGetFirstWeekdayOfTheMonth:displayingYear withMonth:displayingMonth];
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-15)/7, _calendarCollectionView.frame.size.height/5);
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    _calendarCollectionView.collectionViewLayout = flow;
    
    _calendarCollectionView.delegate = self;
    _calendarCollectionView.dataSource = self;
    [_calendarCollectionView reloadData];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipeRight.delegate = self;
    swipeRight.numberOfTouchesRequired = 1;
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_calendarCollectionView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeLeft.delegate = self;
    swipeLeft.numberOfTouchesRequired = 1;
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_calendarCollectionView addGestureRecognizer:swipeLeft];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISwipeGestureRecognizer Action
-(void)didSwipeRight: (UISwipeGestureRecognizer*) recognizer {
    //NSLog(@"Swiped Right");
    [UIView transitionWithView:_calendarCollectionView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^(void) {
                        if(displayingMonth <= 1)
                        {
                            displayingYear = displayingYear - 1;
                            displayingMonth = 12;
                        }
                        else
                        {
                            displayingMonth = displayingMonth - 1;
                        }
                        
                        numberOfDaysInMonth = [self toGetNumberOfDaysInMonth:displayingYear withMonth:displayingMonth];
                        firstDayOfTheWeek = [self toGetFirstWeekdayOfTheMonth:displayingYear withMonth:displayingMonth];
                        
                        [_calendarCollectionView reloadData];
                    } completion:NULL];
    
}

-(void)didSwipeLeft: (UISwipeGestureRecognizer*) recognizer {
    //NSLog(@"Swiped Left");
    [UIView transitionWithView:_calendarCollectionView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^(void) {
                        if(displayingMonth >= 12)
                        {
                            displayingYear = displayingYear + 1;
                            displayingMonth = 1;
                        }
                        else
                        {
                            displayingMonth = displayingMonth + 1;
                        }
                        
                        numberOfDaysInMonth = [self toGetNumberOfDaysInMonth:displayingYear withMonth:displayingMonth];
                        firstDayOfTheWeek = [self toGetFirstWeekdayOfTheMonth:displayingYear withMonth:displayingMonth];
                        
                        [_calendarCollectionView reloadData];
                    } completion:NULL];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer     shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //NSLog(@"Asking permission");
    return YES;
}

-(int)toGetNumberOfDaysInMonth:(int)year withMonth:(int)month
{
    currentWeekdayCell = 0;
    presentDay = 1;
    firstDayOfTheMonth = NO;
    monthEndsWithFirstCell = NO;
    monthEndsWithSecondCell = NO;
    
    NSString * dateString = [NSString stringWithFormat: @"%d", month];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSDate* myDate = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:myDate];
    
    _labelMonthAndYear.text = [NSString stringWithFormat:@"%@ %d", stringFromDate,year];
    
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // Set your year and month here
    [components setYear:year];
    [components setMonth:month];
    
    NSDate *date = [calendar dateFromComponents:components];
    NSRange range1 = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (int)range1.length;
}
-(int)toGetFirstWeekdayOfTheMonth:(int)year withMonth:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date567 = [gregorian dateFromComponents:comps];
    
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comp = [cal components:NSCalendarUnitWeekday fromDate:date567];
    return (int)[comp weekday];
    
}

#pragma mark - CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 35;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Calendar" forIndexPath:indexPath];
    
    
    
    if(!firstDayOfTheMonth)
    {
        if(currentWeekdayCell > 7)
        {
            currentWeekdayCell = 0;
        }
        else
        {
            currentWeekdayCell ++;
        }
    }
    
    //    NSLog(@"presentDay --> %d   | numberOfDaysInMonth --> %d",presentDay,numberOfDaysInMonth);
    if(firstDayOfTheWeek == 7 && !monthEndsWithFirstCell)
    {
        if(numberOfDaysInMonth == 29 || numberOfDaysInMonth == 28)
        {\
            cell.dayLabel.text = @"";
            cell.eventLabel.text = @"";
            monthEndsWithFirstCell = YES;
        }
        else
        {
            if(numberOfDaysInMonth == 30 && numberOfDaysInMonth < 31)
            {
                cell.dayLabel.text = [NSString stringWithFormat:@"%d",numberOfDaysInMonth];
                cell.eventLabel.text = @"";//Can add your events here
                monthEndsWithFirstCell = YES;
                
            }
            else if (numberOfDaysInMonth == 31)
            {
                if(!monthEndsWithSecondCell)
                {
                    cell.dayLabel.text = [NSString stringWithFormat:@"%d",numberOfDaysInMonth - 1];
                    cell.eventLabel.text = @"";//Can add your events here
                    monthEndsWithSecondCell = YES;
                    
                }
                else
                {
                    cell.dayLabel.text = [NSString stringWithFormat:@"%d",numberOfDaysInMonth];
                    cell.eventLabel.text = @"";//Can add your events here
                    monthEndsWithFirstCell = YES;
                }
            }
            else
            {
                cell.dayLabel.text = [NSString stringWithFormat:@"%d",numberOfDaysInMonth];
                cell.eventLabel.text = @"";//Can add your events here
            }
        }
    }
    else
    {
        if(firstDayOfTheWeek == 6 && numberOfDaysInMonth == 31 && !monthEndsWithFirstCell)
        {
            cell.dayLabel.text = [NSString stringWithFormat:@"%d",numberOfDaysInMonth];
            cell.eventLabel.text = @"";//Can add your events here
            monthEndsWithFirstCell = YES;
        }
        else
        {
            if(presentDay <= numberOfDaysInMonth)
            {
                
                if(currentWeekdayCell == firstDayOfTheWeek)
                {
                    firstDayOfTheMonth = YES;
                    cell.dayLabel.text = [NSString stringWithFormat:@"%d",presentDay];
                    cell.eventLabel.text = @""; //Can add your events here
                    
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
                    
                    if([components year] == displayingYear && [components month] == displayingMonth && [components day] == presentDay)
                    {
                        cell.dayLabel.textColor = [UIColor redColor];
                    }
                    else
                    {
                        cell.dayLabel.textColor = [UIColor blackColor];
                    }
                    presentDay = presentDay + 1;
                }
                else
                {
                    cell.dayLabel.text = @"";
                    cell.eventLabel.text = @"";
                }
            }
            else
            {
                cell.dayLabel.text = @"";
                cell.eventLabel.text = @"";
            }
        }
    }
    
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    return cell;
}


@end
