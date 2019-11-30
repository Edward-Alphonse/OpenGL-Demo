//
//  Demo2ViewController.m
//  Demo
//
//  Created by 何知昶 on 2019/11/28.
//  Copyright © 2019 何知昶. All rights reserved.
//

#import "Demo2ViewController.h"
#import <GLKit/GLKit.h>

static const GLKVector3 positions[] = {
    {1.0f, 0.0f, 0.0f},
    {0.0f, 1.0f, 0.0f},
    {0.0f, -1.0f, 0.0f}
};

static const GLKVector4 colors[] = {
    {0.0f, 0.0f, 1.0f, 1.0f},
    {0.0f, 0.0f, 1.0f, 1.0f},
    {0.0f, 0.0f, 1.0f, 1.0f}
};

GLuint vbos[2];

@interface Demo2ViewController ()

@property(nonatomic, strong) GLKBaseEffect *baseEffect;

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    glClearColor(0.0f,
                 0.0f,
                 0.0f,
                 0.0f);
   
    glGenBuffers(2, vbos);
    glBindBuffer(GL_ARRAY_BUFFER, vbos[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(positions), positions, GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbos[1]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbos[0]);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,
                          sizeof(GLKVector3) / sizeof(GL_FLOAT),
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GLKVector3),
                          NULL);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbos[1]);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          sizeof(GLKVector4) / sizeof(GL_FLOAT),
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(GLKVector4),
                          NULL);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glDrawArrays(GL_TRIANGLES,
                 0,
                 3);
}


@end
