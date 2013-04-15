//
//  ViewController.h
//  ReverseGeoTest
//
//  Created by Tom Horn on 15/04/13.
//  Copyright (c) 2013 Tom Horn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property IBOutlet UITextField * address;
@property IBOutlet MKMapView * map;

-(IBAction) onRGeo:(id)sender;

@end
