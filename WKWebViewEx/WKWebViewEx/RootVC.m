//
//  RootVC.m
//  WKWebViewEx
//
//  Created by hd-apple10 on 10/14/16.
//
//

#import "RootVC.h"
#import "ProgressVC.h"
#import "JSHandlerVC.h"

@interface RootVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@end


@implementation RootVC


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"WKWebView";
    
    self.datas = [NSMutableArray array];
    [self.datas addObjectsFromArray:@[@"Progress", @"JS Handler"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RootCell"];
    
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootCell"];
    
    cell.textLabel.text = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *str = self.datas[indexPath.row];
    if ([str isEqualToString:@"Progress"])
    {
        ProgressVC *vc = [[ProgressVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([str isEqualToString:@"JS Handler"])
    {
        JSHandlerVC *vc = [[JSHandlerVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
















@end










