//
//  ViewController.m
//  ReverseGeoTest
//
//  Created by Tom Horn on 15/04/13.
//  Copyright (c) 2013 Tom Horn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CLGeocoder * m_geocoder;
}

@end

@implementation ViewController

@synthesize address;
@synthesize map;

-(void) dealloc
{
    // also any geocoding
    [m_geocoder cancelGeocode];
    m_geocoder = nil;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    m_geocoder = [CLGeocoder new];
    
    self.address.text = @"Opera House, New South Wales";
}

-(IBAction) onRGeo:(id)sender
{
    // clear the map first
    [self.map removeAnnotations:self.map.annotations];
    
    [self.address resignFirstResponder];
    
    CLRegion * currentRegion = [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(-33.861506931797535,151.21294498443604)
                                                                       radius:25000 identifier:@"NEARBY"];
    
    [m_geocoder geocodeAddressString:self.address.text inRegion:currentRegion completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if (!placemarks)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No placemarks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        for (int i = 0; i < [placemarks count]; i++)
        {
            CLPlacemark * thisPlacemark = [placemarks objectAtIndex:i];

            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = thisPlacemark.location.coordinate;
            annotationPoint.title = thisPlacemark.name;
            [self.map addAnnotation:annotationPoint];
            [self.map setCenterCoordinate:thisPlacemark.location.coordinate];
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (thisPlacemark.location.coordinate, 25000, 25000);
            [self.map setRegion:region animated:NO];
        }
    }];
}

@end
