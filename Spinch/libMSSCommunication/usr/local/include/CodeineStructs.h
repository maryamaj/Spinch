//
//  CodeineStructs.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#ifndef pieMenu_CodeineStructs_h
#define pieMenu_CodeineStructs_h

typedef struct cd
{
    unsigned char byteValue;
    unsigned char _pad8;
    unsigned char _pad16;
    unsigned char _pad32;
    int positionX;
    int positionY;
    int orientation;
} ContactDescriptor;

typedef struct pcd
{
    unsigned char count;
    ContactDescriptor* descArray;
    
} PackedContactDescriptors;

static int sizeofCD = 4*sizeof(char) + 3 * sizeof(int);

#endif
