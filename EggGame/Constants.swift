//
//  Constants.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/6/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit

//constants
//first level crack
var EggCrackVelocityLevelOne: Double = 40
var EggCrackVelocityLevelTwo: Double = 60

//objects category bit masks
let ballCategory:UInt32=0x1 << 1
let basketCategory:UInt32=0x1 << 5
let toolKitCategory:UInt32=0x1 << 2
let frameCategory:UInt32=0x1 << 3//for frame
let sharpRockCategory:UInt32 = 0x1 << 4
let starCategory:UInt32 = 0x1 << 7
let cloudCategory: UInt32 = 0x1 << 8


