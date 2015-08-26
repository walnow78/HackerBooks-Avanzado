// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLPDF.m instead.

#import "_POLPDF.h"

const struct POLPDFAttributes POLPDFAttributes = {
	.file = @"file",
};

const struct POLPDFRelationships POLPDFRelationships = {
	.book = @"book",
};

@implementation POLPDFID
@end

@implementation _POLPDF

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (POLPDFID*)objectID {
	return (POLPDFID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic file;

@dynamic book;

@end

