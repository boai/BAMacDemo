//
//  ViewController.m
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "ViewController.h"
#import "BABugsDoc.h"
#import "BAModelData.h"
#import "EDStarRating.h"

#import "NSImage+BAKit.h"
#import <Quartz/Quartz.h>


@interface ViewController ()
<
    NSTableViewDelegate,
    NSTableViewDataSource
>

@property (nonatomic, strong) NSMutableArray *dataArrayBugs;

@property (weak) IBOutlet NSTableView *bugsTableView;
@property (weak) IBOutlet NSTextField *bugTitleTextField;
@property (weak) IBOutlet EDStarRating *bugRating;
@property (weak) IBOutlet NSImageView *bugImageView;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *deleteButton;

- (IBAction)addButtonAction:(NSButton *)sender;
- (IBAction)deleteButtonAction:(NSButton *)sender;



@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 私有方法
- (void)setupUI
{
    self.bugsTableView.delegate = self;
    self.bugsTableView.dataSource = self;
    
    [self setupEDStarRaing];
}

/*! 初始化设置EDStarRaing */
- (void)setupEDStarRaing
{
    self.bugRating.starImage = [NSImage imageNamed:@"star.png"];
    self.bugRating.starHighlightedImage = [NSImage imageNamed:@"shockedface2_full"];
    self.bugRating.starImage = [NSImage imageNamed:@"shockedface2_empty"];
    self.bugRating.maxRating = 5.0f;
    self.bugRating.delegate = (id<EDStarRatingProtocol>) self;
    self.bugRating.horizontalMargin = 2;
    self.bugRating.editable = YES;
    self.bugRating.displayMode = EDStarRatingDisplayFull;
    self.bugRating.rating = 0.0;
    self.bugRating.editable = NO;
}

/*! 获取选中的数据模型 */
- (BABugsDoc *)selectedBugData
{
    /*! 获取table view 的选中行号 */
    NSInteger selectedRow = [self.bugsTableView selectedRow];
    if (selectedRow >= 0 && self.dataArrayBugs.count > selectedRow)
    {
        BABugsDoc *selectedData = self.dataArrayBugs[selectedRow];
        return selectedData;
    }
    return nil;
}

/*! 根据数据设置视图信息 */
- (void)setDetailInfo:(BABugsDoc *)data
{
    NSString *title = nil;
    NSImage *image = nil;
    
    float rating = 0.0;
    /*! 如果有数据 */
    if (data != nil)
    {
        title = data.data.title;
        image = data.fullImage;
        rating = data.data.rating;
    }
    
    [self.bugTitleTextField setStringValue:title];
    [self.bugImageView setImage:image];
    [self.bugRating setRating:rating];
}

#pragma mark - 通知

#pragma mark - NSTableViewDelegate / NSTableViewDataSource
/*! 这个方法返回列表的行数 : 类似于iOS中的numberOfRowsInSection */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataArrayBugs.count;
}

/*! 这个方法返回列表的cell ：参考iOS中的 cellForRowAtIndexPath: */
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    /*! 1.创建可重用的cell: */
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    /*! 2. 根据重用标识，设置cell 数据 */
    if ([tableColumn.identifier isEqualToString:@"BugColumn"])
    {
        BABugsDoc *bugDoc = self.dataArrayBugs[row];
        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = bugDoc.data.title;
        return cellView;
    }
    return cellView;
}

/*! table view 选中一行的时候，会调用这个方法 */
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    /*! 获取选中的数据 */
    BABugsDoc *selecctData = [self selectedBugData];
    /*! 根据数据，设置详情视图内容 */
    [self setDetailInfo:selecctData];
    
    /*! Enable/Disable buttons based on selection */
    BOOL buttonsEnabled = (selecctData != nil);
    
    [self.bugRating setEditable:buttonsEnabled];
    [self.bugTitleTextField setEnabled:buttonsEnabled];
}

#pragma mark - Custom Delegate


#pragma mark - event response
- (IBAction)addButtonAction:(NSButton *)sender
{
    /*! 1.创建数据模型 */
    BABugsDoc *newData = self.dataArrayBugs[random()%4];
    /*! 2. 添加模型到数组中 */
    [self.dataArrayBugs addObject:newData];
    /*! 3. 获取添加后的行号 */
    NSInteger newIndex = self.dataArrayBugs.count - 1;
    /*! 4. 在table view 中插入新行 */
    [self.bugsTableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newIndex] withAnimation:NSTableViewAnimationEffectFade];
    /*! 5. 设置新行选中，并可见 */
    [self.bugsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newIndex] byExtendingSelection:NO];
    [self.bugsTableView scrollRowToVisible:newIndex];
}

- (IBAction)deleteButtonAction:(NSButton *)sender
{
    
}


#pragma mark - getters and setters
- (NSMutableArray *)dataArrayBugs
{
    if (!_dataArrayBugs)
    {
        _dataArrayBugs = @[].mutableCopy;
        
        BABugsDoc *bug1 = [[BABugsDoc alloc] initWithTitle:@"Potato Bug" rating:4 thumbImage:[NSImage imageNamed:@"potatoBugThumb.jpg"] fullImage:[NSImage imageNamed:@"potatoBug.jpg"]];
        BABugsDoc *bug2 = [[BABugsDoc alloc] initWithTitle:@"House Centipede" rating:3 thumbImage:[NSImage imageNamed:@"centipedeThumb.jpg"] fullImage:[NSImage imageNamed:@"centipede.jpg"]];
        BABugsDoc *bug3 = [[BABugsDoc alloc] initWithTitle:@"Wolf Spider" rating:5 thumbImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"] fullImage:[NSImage imageNamed:@"wolfSpider.jpg"]];
        BABugsDoc *bug4 = [[BABugsDoc alloc] initWithTitle:@"Lady Bug" rating:1 thumbImage:[NSImage imageNamed:@"ladybugThumb.jpg"] fullImage:[NSImage imageNamed:@"ladybug.jpg"]];

        [_dataArrayBugs addObject:bug1];
        [_dataArrayBugs addObject:bug2];
        [_dataArrayBugs addObject:bug3];
        [_dataArrayBugs addObject:bug4];
        
        [self.bugsTableView reloadData];
    }
    return _dataArrayBugs;
}


@end
