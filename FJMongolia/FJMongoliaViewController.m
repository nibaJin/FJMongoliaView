//
//  FJMongoliaViewController.m
//  FJMongolia
//
//  Created by fujin on 17/2/10.
//  Copyright © 2017年 fujin. All rights reserved.
//

#import "FJMongoliaViewController.h"
#import "FJMongoliaView.h"

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

@interface FJMongoliaViewController ()

@property (strong, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

@end

@implementation FJMongoliaViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self performSelector:@selector(showMongolia) withObject:nil afterDelay:0.4];
}

- (void)showMongolia
{
    NSString *key = [NSString stringWithFormat:@"FJ_mongolia_%zd",_mongoliaType];
    
    [USER_DEFAULT registerDefaults:@{ key : @(YES) }];
    
    if ([[USER_DEFAULT objectForKey: key] boolValue]) {
        FJMongoliaView *mongoliaView;
        
        UIImage *image = [UIImage imageNamed:@"recommend_mongolia"];
        CGRect imageRect = CGRectMake(self.displayLabel.frame.origin.x + CGRectGetWidth(self.displayLabel.frame)*0.5 - image.size.width, self.displayLabel.frame.origin.y - image.size.height, image.size.width, image.size.height);
        
        switch (_mongoliaType) {
            case FJMongoliaRectType:
            {
                mongoliaView = [[FJMongoliaView alloc] initWithFrame:self.view.bounds withRoundedRect:self.displayLabel.frame cornerRadius:2 hintImage:image imageFrame:imageRect];
                
            }
                break;
            case FJMongoliaCircleType:
            {
                mongoliaView = [[FJMongoliaView alloc] initWithFrame:self.view.bounds withCircleCenter:CGPointMake(self.displayLabel.center.x, self.displayLabel.center.y-CGRectGetHeight(self.displayLabel.frame)*0.5) radius:CGRectGetWidth(self.displayLabel.frame)*0.5 startAngle:0 endAngle:-M_PI hintImage:image imageFrame:imageRect];
            }
                break;
            case FJMongoliaNRectType:
            {
                NSArray *rectArray = @[[NSValue valueWithCGRect:self.displayLabel.frame],[NSValue valueWithCGRect:self.otherLabel.frame],[NSValue valueWithCGRect:self.authorLabel.frame]];
                mongoliaView = [[FJMongoliaView alloc] initWithFrame:self.view.bounds withRoundedRects:rectArray hintImage:nil imageFrame:CGRectZero];
            }
                break;
                
            default:
                break;
        }
        
        if (mongoliaView) {
            mongoliaView.key = key;
            [mongoliaView showInView:self.navigationController.view];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#warning - 项目中去掉
- (void)dealloc
{
    // 项目中可注释掉
    NSString *key = [NSString stringWithFormat:@"FJ_mongolia_%zd",_mongoliaType];
    [USER_DEFAULT removeObjectForKey:key];
}

@end
