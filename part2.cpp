#include <stdio.h>

#include "cll.h"
#include "util.h"

#include <vector>

void CL::loadData(std::vector<Vec4> pos, std::vector<Vec4> col, std::vector<Vec4> F_p, std::vector<Vec4> F_s, std::vector<Vec4> Mom)
{
    //store the number of particles and the size in bytes of our arrays
    num = pos.size();
    array_size = num * sizeof(Vec4);
    
    //create VBOs (defined in util.cpp)
    p_vbo = createVBO(&pos[0], array_size, GL_ARRAY_BUFFER, GL_DYNAMIC_DRAW);
    c_vbo = createVBO(&col[0], array_size, GL_ARRAY_BUFFER, GL_DYNAMIC_DRAW);

    //make sure OpenGL is finished before we proceed
    glFinish();
    printf("gl interop!\n");
    // create OpenCL buffer from GL VBO
    cl_vbos.push_back(cl::BufferGL(context, CL_MEM_READ_WRITE, p_vbo, &err));
    //printf("v_vbo: %s\n", oclErrorString(err));
    cl_vbos.push_back(cl::BufferGL(context, CL_MEM_READ_WRITE, c_vbo, &err));
    //we don't need to push any data here because it's already in the VBO
    
    //create the OpenCL only arrays
    cl_F_p = cl::Buffer(context, CL_MEM_READ_WRITE, array_size, NULL, &err);
    cl_F_s = cl::Buffer(context, CL_MEM_READ_WRITE, array_size, NULL, &err);
    cl_Mom = cl::Buffer(context, CL_MEM_READ_WRITE, array_size, NULL, &err);
    
    printf("Pushing data to the GPU\n");
    //push our CPU arrays to the GPU
    //data is tightly packed in std::vector starting with the adress of the first element
    err = queue.enqueueWriteBuffer(cl_F_p, CL_TRUE, 0, array_size, &F_p[0], NULL, &event);
    err = queue.enqueueWriteBuffer(cl_F_s, CL_TRUE, 0, array_size, &F_s[0], NULL, &event);
    err = queue.enqueueWriteBuffer(cl_Mom, CL_TRUE, 0, array_size, &Mom[0], NULL, &event);
    queue.finish();
 
    queue.finish();
}

void CL::popCorn()
{
    printf("in popCorn\n");
    //initialize our kernel from the program
    //kernel = clCreateKernel(program, "part1", &err);
    //printf("clCreateKernel: %s\n", oclErrorString(err));
    try{
        kernel = cl::Kernel(program, "part2", &err);
    }
    catch (cl::Error er) {
        printf("ERROR: %s(%s)\n", er.what(), oclErrorString(er.err()));
    }

    //set the arguements of our kernel
    try
    {
        err = kernel.setArg(0, cl_vbos[0]); //position vbo
        err = kernel.setArg(1, cl_vbos[1]);  //color vbo
        err = kernel.setArg(2, cl_F_p); 
        err = kernel.setArg(3, cl_F_s); 
        err = kernel.setArg(4, cl_Mom); 

    }
    catch (cl::Error er) {
        printf("ERROR: %s(%s)\n", er.what(), oclErrorString(er.err()));
    }
    
    //Wait for the command queue to finish these commands before proceeding
    queue.finish();
}



void CL::runKernel()
{
    //this will update our system by calculating new velocity and updating the positions of our particles
    //Make sure OpenGL is done using our VBOs
    glFinish();
    // map OpenGL buffer object for writing from OpenCL
    //this passes in the vector of VBO buffer objects (position and color)
    err = queue.enqueueAcquireGLObjects(&cl_vbos, NULL, &event);
    //printf("acquire: %s\n", oclErrorString(err));
    queue.finish();
    
    kernel.setArg(5, 1e-3f); //pass in the timestep
    kernel.setArg(6, 0.38f);
    kernel.setArg(7, 1.0f); 
    kernel.setArg(8, (float)1.4f*0.38f*(15.0f-1.0f)); 
    kernel.setArg(9, 1e4f); 
    kernel.setArg(10, 40.0f); 

    //execute the kernel
    err = queue.enqueueNDRangeKernel(kernel, cl::NullRange, cl::NDRange(num,num), cl::NullRange, NULL, &event); 
    //printf("clEnqueueNDRangeKernel: %s\n", oclErrorString(err));
    queue.finish();
  
    //Release the VBOs so OpenGL can play with them
    err = queue.enqueueReleaseGLObjects(&cl_vbos, NULL, &event);
    //printf("release gl: %s\n", oclErrorString(err));
    queue.finish();
}


