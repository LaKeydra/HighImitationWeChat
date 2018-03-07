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
@property (weak, nonatomic) IBOutlet UITableView *diallingTableView;

@end

@implementation DiallingCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readData];
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
        if (country.latin.length > 0) {
            indexKey = [[country.latin substringToIndex:1] uppercaseString];
            char c = [indexKey characterAtIndex:0];
            if ( c < 'A' || c > 'Z') {
                continue;
            }
        } else {
            continue;
        }
        
        NSMutableArray *array = sortDic[indexKey];
        if (!array) {
            array = [NSMutableArray array];
            sortDic[indexKey] = array;
        }
        [array addObject:country];
    }
    
    //排序
    for (NSString *key in sortDic.allKeys) {
        NSArray *array = sortDic[key];
        
        array = [array sortedArrayUsingComparator:^NSComparisonResult(CountryModel *obj1,CountryModel *obj2) {
            return [obj1.name localizedStandardCompare:obj2.name];
        }];
        
        sortDic[key] = array;
    }
    
    self.codeDic = sortDic;
    [self.diallingTableView reloadData];
}

- (void)insertNewObject:(id)sender{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.diallingTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.codeDic[[NSString stringWithFormat:@"%c",(char)('A'+section)]];
    return array.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexArray = [@[] mutableCopy];
    for (int i = 0; i < 26; ++i) {
        NSString *index  = [NSString stringWithFormat:@"%c",(char)('A'+i)];
        NSArray *array = self.codeDic[index];
        if (array.count > 0) {
            [indexArray addObject:index];
        }
    }
    return indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    char firstChar = [title characterAtIndex:0];
    return firstChar - 'A';
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = [NSString stringWithFormat:@" %c",(char)('A'+section)];
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *array = self.codeDic[[NSString stringWithFormat:@"%c", (char)('A'+indexPath.section)]];
    CountryModel *country = array[indexPath.row];
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = country.dial_code;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    NSArray *array = self.codeDic[[NSString stringWithFormat:@"%c",(char)('A'+indexPath.section)]];
    CountryModel *country = array[indexPath.row];
    [self.navigationController popViewControllerAnimated:true];
    self.doneBlock(country);
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
