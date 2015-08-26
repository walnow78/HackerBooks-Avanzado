// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLImage.h instead.

@import CoreData;

extern const struct POLImageAttributes {
	__unsafe_unretained NSString *file;
} POLImageAttributes;

extern const struct POLImageRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *locatation;
	__unsafe_unretained NSString *note;
} POLImageRelationships;

@class POLBook;
@class POLLocation;
@class POLNote;

@interface POLImageID : NSManagedObjectID {}
@end

@interface _POLImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLImageID* objectID;

@property (nonatomic, strong) NSData* file;

//- (BOOL)validateFile:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLLocation *locatation;

//- (BOOL)validateLocatation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLNote *note;

//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;

@end

@interface _POLImage (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveFile;
- (void)setPrimitiveFile:(NSData*)value;

- (POLBook*)primitiveBook;
- (void)setPrimitiveBook:(POLBook*)value;

- (POLLocation*)primitiveLocatation;
- (void)setPrimitiveLocatation:(POLLocation*)value;

- (POLNote*)primitiveNote;
- (void)setPrimitiveNote:(POLNote*)value;

@end
