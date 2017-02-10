//
//  FJMongoliaViewController.h
//  FJMongolia
//
//  Created by fujin on 17/2/10.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FJMongoliaType)
{
    FJMongoliaRectType ,
    FJMongoliaCircleType ,
    FJMongoliaNRectType
};
@interface FJMongoliaViewController : UIViewController

@property (nonatomic, assign) FJMongoliaType mongoliaType;

@end
