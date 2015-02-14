//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "Businesscell.h"
#import "FiltersViewController.h"
#import "MBProgressHUD.h"

// Yelp keys
NSString *const kYelpConsumerKey = @"hglIeq2RP56tBDlBFB1omA";
NSString *const kYelpConsumerSecret = @"E7ikJ1kWzg7itMokjzlMv4pL23Y";
NSString *const kYelpToken = @"zW60JK66xpVTz2rbfIRQTYTijolZLeTX";
NSString *const kYelpTokenSecret = @"-4MnwTvRtE93DRKn9eNfyblZxzw";

// other constants
NSString *const kMapButtonTitle = @"Map";
NSString *const kFiltersButtonTitle = @"Filters";
NSString *const kTitle = @"List";



@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property(nonatomic, strong) YelpClient *client;
@property(atomic, strong) NSArray *businesses;
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) UISearchBar *searchBar;
@property(strong, nonatomic) UIBarButtonItem *filtersButton;
@property(strong, nonatomic) UIBarButtonItem *mapButton;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];

        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response: %@", response);
            NSArray *businessDictionaries = response[@"businesses"];
            self.businesses = [Business bussinessesWithDictionaries:businessDictionaries];
            [self.tableView reloadData];
        }                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // add search bar to navigation bar
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchDisplayController.displaysSearchBarInNavigationBar = YES;

    // set navigation bar buttons
    self.filtersButton = [[UIBarButtonItem alloc]initWithTitle:kFiltersButtonTitle
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(didClickFiltersButton)];
    UIImage *mapImage = [UIImage imageNamed:@"map79.png"];
    self.mapButton = [[UIBarButtonItem alloc] initWithImage:mapImage landscapeImagePhone:mapImage
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(didClickMapButton)];
    self.navigationItem.leftBarButtonItem = self.filtersButton;
    self.navigationItem.rightBarButtonItem = self.mapButton;
    self.filtersButton.enabled = NO;
    self.mapButton.enabled = NO;


    // delegates
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;


    // cell registration
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    // cell auto dim.
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.title = kTitle;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

#pragma mark - Search bar delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // hide keyboard

    // set filters ...
    
    // do search
    [self doSearch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // hide keyboard
}

#pragma mark - private methods

- (void)didClickFiltersButton {

    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)didClickMapButton {
    // show map
}

- (void)doSearch {

    // show spinner while searching
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.client searchWithTerm:self.searchBar.text success:^(AFHTTPRequestOperation *operation, id response) {

        // initialize model
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business bussinessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
        // end spinner
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // now enable buttons
        self.filtersButton.enabled = YES;
        self.mapButton.enabled = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO: error tab instead?
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Network error" message: @"Check your connection" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alert show];
        NSLog(@"error: %@", [error description]);

        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


@end
