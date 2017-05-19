//
//  CalendarViewController.h
//  CustomCalender
//
//  Created by Nithin.k on 18/05/17.
//  Copyright © 2017 NK dreams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
{
    BOOL monthEndsWithFirstCell;
    BOOL monthEndsWithSecondCell;
    BOOL firstDayOfTheMonth;
    BOOL lastDayOfTheMonth;
    int currentWeekdayCell; //To check the weekday
    int numberOfDaysInMonth; // total number of days in a month
    int presentDay; // current displaying day
    int firstDayOfTheWeek; //first day of the week for specific month
    int displayingMonth;
    int displayingYear;
}
@property (strong, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *labelMonthAndYear;

@end
