//
//  DemoViewController.m
//  Demo
//
//  Created by 何知昶 on 2019/11/28.
//  Copyright © 2019 何知昶. All rights reserved.
//

#import "DemoViewController.h"

typedef struct {
    GLKVector3 position;
    GLKVector4 color;
} Vertex;

@interface DemoViewController()

@property(nonatomic, strong) GLKBaseEffect *baseEffect;

@end

@implementation DemoViewController

Vertex vertexes[] = {
    {{0.0f, 1.0f, 0.0f}, {1.0f, 0.0f, 0.0f, 1.0f}},
    {{-1.0f, 0.0f, 0.0f},{0.0f, 1.0f, 0.0f, 1.0f}},
    {{1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f, 1.0f}}
};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一步，设置context
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass: [GLKView class]], @"is not glkview");
    
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:view.context];
    
    //第二步，设置baseEffect对象（封装了对着色器的操作），设置清楚颜色
    _baseEffect = [[GLKBaseEffect alloc] init];
    //glClearColor仅仅是设置glClear的时候的颜色值
    glClearColor(0.f, 0.f, 0.f, 0.f);
    
    
    //第三步，创建VBO对象
    GLuint vbo;
    //生成缓冲对象，缓冲对象对应着GPU中的一块内存
    glGenBuffers(1, &vbo);
    //将缓冲对象绑定到context，并制定缓冲对象类型
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    //为缓冲对象分配大小，将数据写入缓冲对象，指定数据流向
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexes), vertexes, GL_STATIC_DRAW);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    //第四步，baseEffect准备绘制，清楚上一帧缓存
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    
    //第五步，设置要使用的顶点属性，告诉GPU如何在缓存中取某个顶点属性的数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition,  //顶点属性
                          3,    //该顶点属性的分量个数，比如position由(x, y, z)组成，个数为3
                          GL_FLOAT, //该顶点属性分量的类型
                          GL_FALSE,
                          sizeof(Vertex),
                          NULL);
    
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor,
                          sizeof(GLKVector4) / sizeof(GL_FLOAT),
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(Vertex),
                          NULL + sizeof(GLKVector3));
    
    glDrawArrays(GL_TRIANGLES,
                 0,     //绘制的第一个顶点在数组中的位置
                 3);    //绘制的顶点个数
}


@end
