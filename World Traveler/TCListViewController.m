//
//  TCViewController.m
//  World Traveler
//
//  Created by Michał Kozak on 18.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCListViewController.h"
#import "TCFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"
#import "TCMapViewController.h"
#import "TCAppDelegate.h"

static NSString *const kCLIENTID = @"C0WL3OG5MOZ1VEPSSAK3T2D20JNG00ZJNRUVYMQ3H23DEPP4";
static NSString *const kCLIENTSECRET = @"3QHKJN3VYNZ1MSDPM1GD3GCMHWDJP2DUIR01DZSTSRBJBZ5N";

#define latitudeOffset 0.01
#define longitudeOffset 0.01

@interface TCListViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation TCListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
	// Do any additional setup after loading the view, typically from a nib.
    TCFourSquareSessionManager *sessionManager = [TCFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc]init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    TCMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue=venue;
}


- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [[self drawControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    [[TCFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude +latitudeOffset, location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id": kCLIENTID, @"client_secret":kCLIENTSECRET, @"v" : @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ERROR: %@",error);
    }];
    
}

#pragma mark - TV DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.venues count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}

#pragma mark - DrawerController

-(MMDrawerController *) drawControllerFromAppDelegate
{
    TCAppDelegate *appDelegate = (TCAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
