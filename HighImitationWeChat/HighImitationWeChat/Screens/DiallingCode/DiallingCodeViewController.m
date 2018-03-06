//
//  DiallingCodeViewController.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/6.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "DiallingCodeViewController.h"
#import "CountryModel.h"

@interface DiallingCodeViewController ()

@property NSMutableArray *objects;
@property NSMutableDictionary *codeDic;

@end

@implementation DiallingCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"diallingcode" ofType:@"json"]];
    NSError *error = nil;
    NSArray *codeArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        return;
    }
    
    //读取文件
    NSMutableDictionary *codeDic = [@{} mutableCopy];

    for (NSDictionary *item in codeArray) {
        CountryModel *country = [CountryModel new];
        country.code = item[@"code"];
        country.dial_code = item[@"dial_code"];
        [codeDic setObject:country forKey:country.code];
    }
    
    //获取国家名
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableDictionary *countryDic = [@{} mutableCopy];
    
    for (NSString *countryCode in countryArray) {
        if (codeDic[countryCode]) {
            CountryModel *country = codeDic[countryCode];
            country.name = [locale displayNameForKey: NSLocaleCountryCode value:countryCode];
            country.latin = [self latinize:country.name];
            [countryDic setObject:country forKey:country.code];
        } else {
            NSLog(@"%@ ++ %@",[locale displayNameForKey:NSLocaleCountryCode value:countryCode], countryCode);
        }
    }
    
    //归类
    NSMutableDictionary *sortDic = [@{} mutableCopy];
    for ( CountryModel *country in countryDic.allValues) {
        NSString *indexKey = @"";
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)latinize:(NSString*)str {
    NSMutableString *source = [str mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source;
}

@end
