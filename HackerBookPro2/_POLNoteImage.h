// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLNoteImage.h instead.

@import CoreData;

extern const struct POLNoteImageAttributes {
	__unsafe_unretained NSString *file;
} POLNoteImageAttributes;

extern const struct POLNoteImageRelationships {
	__unsafe_unretained NSString *note;
} POLNoteImageRelationships;

@class POLNote;

@interface POLNoteImageID : NSManagedObjectID {}
@end

@interface _POLNoteImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLNoteImageID* objectID;

@property (nonatomic, strong) NSData* file;

//- (BOOL)validateFile:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) POLNote *note;

//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;

@end

@interface _POLNoteImage (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveFile;
- (void)setPrimitiveFile:(NSData*)value;

- (POLNote*)primitiveNote;
- (void)setPrimitiveNote:(POLNote*)value;

@end
