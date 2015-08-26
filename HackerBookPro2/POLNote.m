#import "POLNote.h"
#import "POLBook.h"
#import "POLLocation.h"
#import "POLImage.h"

@import CoreLocation;

@interface POLNote () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSArray *keys;

@end

@implementation POLNote 

@synthesize locationManager =_locationManager;
@synthesize keys=_keys;


+ (instancetype) noteWithTitle:(NSString*) title
                          text:(NSString*) text
                          book:(POLBook*) book
                       context:(NSManagedObjectContext*)context{
    
    POLNote *note = [POLNote insertInManagedObjectContext:context];
    
    note.title = title;
    note.text = text;
    
    note.creationDate = [NSDate date];
    note.modificationDate = [NSDate date];
    
    // Asigno la relación
    
    note.book = book;
    
    return note;
    
}

// Cada vez que creo una nota nueva, recupero la localización

- (void)awakeFromInsert{

    [super awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ( ((status == kCLAuthorizationStatusAuthorizedWhenInUse) || (status == kCLAuthorizationStatusNotDetermined))
        && [CLLocationManager locationServicesEnabled]) {
        
        // Tenemos acceso a localización
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        // Después de 5 segundos paro la localización.

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [self.locationManager stopUpdatingLocation];
            self.locationManager = nil;
        
        });
        
    }
    
    
    self.keys = @[POLNoteAttributes.title, POLNoteAttributes.text, POLNoteRelationships.image];
    
    [self setupKVO];
}

-(void) awakeFromFetch{
    [super awakeFromFetch];
    [self setupKVO];
}


-(void) willTurnIntoFault{
    [super willTurnIntoFault];
    
    [self tearDownKVO];
    
}

#pragma mark - CLLocationManagerDelegate

-(void) locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
 
    // Como ya tengo un resultado paro la localización para ahorrar batería.
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    // Recupero la última localización
    
    CLLocation *location = [locations lastObject];
    
    self.location = [POLLocation locationInitWith:location note:self context:self.managedObjectContext];
    
    NSLog(@"%f, %f", location.coordinate.latitude, location.coordinate.longitude);
    
}


#pragma mark - KVO

// Uso el KVO para vigilar las propiedades de titulo, texto e imagen por si cambia, modificar la fecha de modificación

-(void)setupKVO{
   
    for (NSString* key in self.keys) {
        
        // Por cada propiedad de la nota lo añado al observer
        
        [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:NULL];
    }
}

-(void)tearDownKVO{
    
    for (NSString* key in self.keys) {
        
        // Por cada propiedad de la nota lo quito del observer
        
        [self removeObserver:self forKeyPath:key];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    // En el caso que me llega una notificación del cambio, modifico la fecha de modificación de la nota
    
    self.modificationDate = [NSDate date];
    
}

@end
