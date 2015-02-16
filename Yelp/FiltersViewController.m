//
//  FiltersViewController.m
//  Yelp
//
//  Created by Emmanuel Texier on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "Filters.h"
#import "YelpException.h"

@interface FiltersViewController () <UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) Filters *filters;
@property(nonatomic, strong) NSMutableDictionary *expandedSections;
@property (nonatomic, strong) UISwitch *dealsSwitch;


- (void)onCancelButton;

- (void)onApplyButton;


@end


@implementation FiltersViewController

#pragma mark - UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
        self.filters = [[Filters alloc] initWithDefaults];
        self.expandedSections = [NSMutableDictionary dictionary];
        self.dealsSwitch = [[UISwitch alloc] init];
        [self.dealsSwitch addTarget:self
                             action:@selector(onDealsSwitch)
                   forControlEvents:UIControlEventValueChanged];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // initialize navigation bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onApplyButton)];

    // table view delegates
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    // cell registration
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FiltersCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil]
//         forCellReuseIdentifier:@"SwitchCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    switch (section) {
        case FilterDistance:
        case FilterSortMode:
            if ([self sectionExpanded:section]) { // collapse section
                [self collapseSection:section selectedRow:indexPath.row];
            } else {
                [self expandSection:section];
            }
            break;
        case FilterDealsOnly:
            // select switch instead
            break;
        case FilterCategories:
            if (![self sectionExpanded:section] && row == 3) {
                [self expandSection:section];
            } else {
                NSUInteger category = (NSUInteger) row;
                [self toggleCategory:category];
            }
            break;

        default:
            @throw [YelpException throwsException];
    }

}

#pragma mark - Table view data source methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case FilterDistance:
            return @"Distance";
        case FilterSortMode:
            return @"Sort By";
        case FilterDealsOnly:
            return @"Offering Deals";
        case FilterCategories:
            return @"Categories";  // only restaurants for the moment
        default:
            @throw [YelpException throwsException];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case FilterDistance:
            if ([self sectionExpanded:section]) {
                return self.filters.distances.count;
            } else {
                return 1;
            }
        case FilterSortMode:
            if ([self sectionExpanded:section]) {
                return self.filters.sortModes.count;
            } else {
                return 1;
            }
        case FilterDealsOnly:
            return 1;
        case FilterCategories:
            if ([self sectionExpanded:section]) {
                return self.filters.categories.count; // all of it
            } else {
                return 4; // including "See all" row
            }
        default:
            @throw [YelpException throwsException];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return FilterCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FiltersCell" forIndexPath:indexPath];
    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    switch (section) {
        case FilterDistance: {
            NSUInteger distanceRow;
            if ([self sectionExpanded:section]) {
                distanceRow = (NSUInteger) row;
                if (distanceRow == [self.filters.selectedDistance unsignedIntegerValue]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;  // mark as selected
                }
            } else {
                distanceRow = [self.filters.selectedDistance unsignedIntegerValue];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cell Expander"]];
            }
            // set cell text
            cell.textLabel.text = self.filters.distances[(NSUInteger) distanceRow][@"name"];

            return cell;
        }
        case FilterSortMode: {
            NSUInteger sortModeRow;
            if ([self sectionExpanded:section]) {
                sortModeRow = (NSUInteger) row;
                if (sortModeRow == [self.filters.selectedSortMode unsignedIntegerValue]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            } else {
                sortModeRow = [self.filters.selectedSortMode unsignedIntegerValue];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cell Expander"]];
            }
            cell.textLabel.text = self.filters.sortModes[(NSUInteger) sortModeRow][@"name"];

            return cell;
        }

        case FilterDealsOnly: {
            cell.textLabel.text = @"Offering a Deal";
            cell.accessoryView = self.dealsSwitch;
            return cell;
        }
        case FilterCategories: {
            if (![self sectionExpanded:section] && row == 3) {
                cell.textLabel.text = @"See All";
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cell Expander"]];
                return cell;
            }
            NSUInteger categoryRow = (NSUInteger) row;
            cell.textLabel.text = self.filters.categories[categoryRow][@"name"];
            if ([self.filters.categories containsObject:@(categoryRow)]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            return cell;
        }

        default:
            @throw [YelpException throwsException];
    }

}

#pragma mark - private methods

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
}


- (void)collapseSection:(NSInteger)section selectedRow:(NSInteger)row {
    NSIndexPath *prevSelectedIndexPath;
    switch (section) {
        case FilterDistance:
            prevSelectedIndexPath = [NSIndexPath indexPathForRow:[self.filters.selectedDistance unsignedIntegerValue]
                                                       inSection:section];
            self.filters.selectedDistance = @(row);
            break;
        case FilterSortMode:
            prevSelectedIndexPath = [NSIndexPath indexPathForRow:[self.filters.selectedSortMode unsignedIntegerValue]
                                                       inSection:section];
            self.filters.selectedSortMode = @(row);
            break;
        default:
            @throw [YelpException throwsException];
    }

    UITableViewCell *prevSelectedCell = [self.tableView cellForRowAtIndexPath:prevSelectedIndexPath];
    prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    NSIndexPath *newSelectedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    UITableViewCell *newSelectedCell = [self.tableView cellForRowAtIndexPath:newSelectedIndexPath];
    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;

    self.expandedSections[@(section)] = @NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) section]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)sectionExpanded:(NSInteger)section {
    return [self.expandedSections[@(section)] boolValue];
}

- (void)expandSection:(NSInteger)section {
    self.expandedSections[@(section)] = @YES;
    [self.tableView reloadSections:[NSIndexSet
                    indexSetWithIndex:(NSUInteger) section]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)onDealsSwitch {
    self.filters.dealsOnlySelected = self.dealsSwitch.on;
}

- (void)toggleCategory:(NSUInteger)categoryIndex {

    // find the cell for this category
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:categoryIndex inSection:FilterCategories];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    // check if already selected
    if ([self.filters.selectedCategories containsObject:self.filters.categories[categoryIndex]]) {  // already selected -> remove it.
        [self.filters.selectedCategories removeObject:self.filters.categories[categoryIndex]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.filters.selectedCategories addObject:self.filters.categories[categoryIndex]]; // add it
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
