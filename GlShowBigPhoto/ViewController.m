//
//  ViewController.m
//  GlShowBigPhoto
//
//  Created by 小柠檬 on 2018/12/11.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import "ViewController.h"
#import "GlShowPhoto/GlShowBigPictureViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *muarray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"http://img18.3lian.com/d/file/201711/11/269010b186b49f6abd729e3c69022632.png",
                       @"http://img4.imgtn.bdimg.com/it/u=967395617,3601302195&fm=26&gp=0.jpg",
                       @"http://img18.3lian.com/d/file/201711/11/269010b186b49f6abd729e3c69022632.png"];
    
    self.muarray = [[NSMutableArray alloc] init];
    for (NSString *url in array) {
        NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        GlShowPictureModel *model = [[GlShowPictureModel alloc] init];
        model.url = [NSURL URLWithString:urlStr];
        [self.muarray addObject:model];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
}

- (IBAction)tovc:(id)sender {
    GlShowBigPictureViewController *vc = [[GlShowBigPictureViewController alloc] init];
    vc.photoModelsArray = self.muarray;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
