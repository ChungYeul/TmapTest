//
//  ViewController.m
//  TmapTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#import "DetailViewController.h"
#define TOOLBAR_HEIGHT 64

@interface ViewController ()<TMapViewDelegate> {
//    TMapView *mapView;
}
@property (strong, nonatomic) TMapView *mapView;
@end

@implementation ViewController
- (void)onClick:(TMapPoint *)TMP {
    NSLog(@"Tapped Point : %@", TMP);
}

- (void)onLongClick:(TMapPoint *)TMP {
    NSLog(@"Long Clicked : %@", TMP);
}

- (void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem {
    NSLog(@"Market ID : %@", [markerItem getID]);
    if ([@"T-ACADEMY" isEqualToString:[markerItem getID]]) {
        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
//        detailVC.urlStr = @"https://skplanet.com";
        detailVC.urlStr = @"https://google.com";
        
        // 모달로 표시
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}

- (void)onCustomObjectClick:(TMapObject *)obj {
    if ([obj isKindOfClass:[TMapMarkerItem class]]) {
        TMapMarkerItem *marker = (TMapMarkerItem *)obj;
        NSLog(@"Marker Clicked.. %@", [marker getID]);
    }
}

- (IBAction)addOverlay:(id)sender {
    CLLocationCoordinate2D coord[5] = {
        CLLocationCoordinate2DMake(37.460143, 126.914062),
        CLLocationCoordinate2DMake(37.469136, 126.981869),
        CLLocationCoordinate2DMake(37.437930, 126.989937),
        CLLocationCoordinate2DMake(37.413255, 126.959038),
        CLLocationCoordinate2DMake(37.426752, 126.913548)
    };
    
    TMapPolygon *polygon = [[TMapPolygon alloc] init];
    [polygon setLineColor:[UIColor redColor]];
    [polygon setPolygonAlpha:0];
    [polygon setLineWidth:8.0f];
    
    for (int i=0; i<5; i++) {
        [polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[i]]];
    }
    [self.mapView addTMapPolygonID:@"관악산" Polygon:polygon];
}

- (IBAction)addMarker:(id)sender {
    NSString *itemID = @"T-ACADEMY";
    
    TMapPoint *point = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    TMapMarkerItem *marker = [[TMapMarkerItem alloc] initWithTMapPoint:point];
    [marker setIcon:[UIImage imageNamed:@"t_logo.png"]];
    
    //
    [marker setCanShowCallout:YES];
    [marker setCalloutTitle:@"티 아카데미"];
    [marker setCalloutRightButtonImage:[UIImage imageNamed:@"right_arrow.png"]];
    
    [self.mapView addTMapMarkerItemID:itemID Marker:marker];
}

- (IBAction)moveToSeoul:(id)sender {
    TMapPoint *centerPoint = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    [self.mapView setCenterPoint:centerPoint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:@"82add192-7843-36bc-b1fd-175e2c70faad"];
    self.mapView.ZoomLevel = 12.0;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
