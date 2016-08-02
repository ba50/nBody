/*
 * Adventures in OpenCL tutorial series
 * Part 2
 *
 * author: Ian Johnson
 * htt://enja.org
 * code based on advisor Gordon Erlebacher's work
 * NVIDIA's examples
 * as well as various blogs and resources on the internet
 */
#include <stdio.h>
#include <stdlib.h>
#include <sstream>
#include <iomanip>
#include <math.h>
#include <fstream>
#include <string>

//OpenGL stuff
#include <GL/glew.h>
#if defined __APPLE__ || defined(MACOSX)
    #include <GLUT/glut.h>
#else
    #include <GL/glut.h>
#endif

//Our OpenCL Particle Systemclass
#include "cll.h"

#include "argon.h"

#define NUM_PARTICLES 3375
CL* example;

//GL related variables
int window_width = 1920;
int window_height = 1080;
int glutWindowHandle = 0;
float translate_z = -10.0f;
// mouse controls
int mouse_old_x, mouse_old_y;
int mouse_buttons = 0;
float rotate_x = 0.0, rotate_y = 0.0;
//main app helper functions
void init_gl(int argc, char** argv);
void appRender();
void appDestroy();
void timerCB(int ms);
void appKeyboard(unsigned char key, int x, int y);
void appMouse(int button, int state, int x, int y);
void appMotion(int x, int y);

//----------------------------------------------------------------------
//quick random function to distribute our initial points
float rand_float(float mn, float mx)
{
    float r = random() / (float) RAND_MAX;
    return mn + (mx-mn)*r;
}


//----------------------------------------------------------------------
int main(int argc, char** argv)
{
	
	int i, j, k;
	double r_ij;

	FILE *XYZ_file, *p_file;

	std::ifstream IN_file;

	std::string buffer;
	std::string IN_filename = "in";
	std::string OUT_filename ="out";
	std::string XYZ_filename = "xyz";

	parameters param;
	state stat;
	Vector sumaP;

	/* Load data */

	IN_file.open(IN_filename);

	IN_file >> param.n;
	std::getline(IN_file, buffer);

	IN_file >> param.m;
	std::getline(IN_file, buffer);

	IN_file >> param.e;
	std::getline(IN_file, buffer);

	IN_file >> param.R;
	std::getline(IN_file, buffer);

	IN_file >> param.f;
	std::getline(IN_file, buffer);

	IN_file >> param.L;
	std::getline(IN_file, buffer);

	IN_file >> param.a;
	std::getline(IN_file, buffer);

	IN_file >> stat.T;
	std::getline(IN_file, buffer);

	IN_file >> param.tau;
	std::getline(IN_file, buffer);

	IN_file >> param.So;
	std::getline(IN_file, buffer);

	IN_file >> param.Sd;
	std::getline(IN_file, buffer);

	IN_file >> param.Sout;
	std::getline(IN_file, buffer);

	IN_file >> param.Sxyz;
	std::getline(IN_file, buffer);

	IN_file.close();

	param.L = param.L * param.a*(param.n - 1);

	/* Okreslanie stanu poczatkowego ukladu */

	srand(time_t(NULL));

	param.N = (int) pow(param.n, 3);

	stat.r = new Vector[param.N];
	stat.p = new Vector[param.N];
	stat.F_p = new Vector[param.N];
	stat.F_s = new Vector[param.N];
printf("init \n");
	for (i = 0; i < param.n; i++){
		for (j = 0; j < param.n; j++){
			for (k = 0; k < param.n; k++){
				stat.r[i + j*param.n + k*param.n*param.n].x = (i - (param.n - 1) / 2.f)*param.a + (j - (param.n - 1) / 2) * param.a / 2.f + (k - (param.n - 1) / 2)*param.a / 2.f;
				stat.r[i + j*param.n + k*param.n*param.n].y = (j - (param.n - 1) / 2)*param.a*sqrt(3.f) / 2 + (k - (param.n - 1) / 2)*param.a*sqrt(3.f) / 6;
				stat.r[i + j*param.n + k*param.n*param.n].z = (k - (param.n - 1) / 2)*param.a * sqrt(2.f / 3.f);
			}
		}
	}
	
/*	XYZ_file = fopen( XYZ_filename.c_str(), "w");

	fprintf(XYZ_file, "%d\n", param.N);
	fprintf(XYZ_file, "STEP:\t%d\n", param.N);
	for (i = 0; i < param.N; i++){
		fprintf(XYZ_file, "Ar\t%f\t%f\t%f\n", stat.r[i].x, stat.r[i].y, stat.r[i].z);
	}
	fprintf(XYZ_file, "\n", param.N);
*/
	printf("p \n");
	for (i = 0; i < param.N; i++){
		stat.r[i].r = sqrt(pow(stat.r[i].x, 2) + pow(stat.r[i].y, 2) + pow(stat.r[i].z, 2));
		
		stat.p[i].x = znak()*sqrt(2*param.m*(-K_B*stat.T*log(r0_1()) / 2));
		stat.p[i].y = znak()*sqrt(2*param.m*(-K_B*stat.T*log(r0_1()) / 2));
		stat.p[i].z = znak()*sqrt(2*param.m*(-K_B*stat.T*log(r0_1()) / 2));

		stat.p[i].r = sqrt(pow(stat.p[i].x, 2) + pow(stat.p[i].y, 2) + pow(stat.p[i].z, 2));
	}

	sumaP.x = 0;
	sumaP.y = 0;
	sumaP.z = 0;
	
	printf("sum p \n");
	for (i = 0; i < param.N; i++){
		sumaP.x += stat.p[i].x;
		sumaP.y += stat.p[i].y;
		sumaP.z += stat.p[i].z;
		
		stat.F_s[i].x = 0;
		stat.F_s[i].y = 0;
		stat.F_s[i].z = 0;

		stat.F_p[i].x = 0;
		stat.F_p[i].y = 0;
		stat.F_p[i].z = 0;
	}

	p_file = fopen( "p", "w");
/*
	for (i = 0; i < param.N; i++){
		stat.p[i].x -= sumaP.x / (double) param.N;
		stat.p[i].y -= sumaP.y / (double) param.N;
		stat.p[i].z -= sumaP.z / (double) param.N;
		fprintf(p_file, "%f\t%f\t%f\n", stat.p[i].x, stat.p[i].y, stat.p[i].z);
	}
*/
	fclose(p_file);
	
	
	/* Initial state */

		stat.V_p = 0;
		stat.V_s = 0;
		printf("main \n");
		for (i = 0; i < param.N; i++){
/*
			if (stat.r[i].r >= param.L){

				stat.V_s += param.f*pow(stat.r[i].r - param.L, 2) / 2;

				stat.F_s[i].x += param.f*(param.L - stat.r[i].r)* stat.r[i].x / stat.r[i].r;
				stat.F_s[i].y += param.f*(param.L - stat.r[i].r)* stat.r[i].y / stat.r[i].r;
				stat.F_s[i].z += param.f*(param.L - stat.r[i].r)* stat.r[i].z / stat.r[i].r;
			}
*/
			for (j = i; j < param.N; j++){
				
				if (i != j){
					r_ij = sqrt(pow(stat.r[i].x - stat.r[j].x, 2) + pow(stat.r[i].y - stat.r[j].y, 2) + pow(stat.r[i].z - stat.r[j].z, 2));

					stat.V_p += param.e*(pow(param.R / r_ij, 12) - 2 * pow(param.R / r_ij, 6));

					stat.F_p[i].x += 12 * param.e*(pow(param.R / r_ij, 12) - pow(param.R / r_ij, 6))*(stat.r[i].x - stat.r[j].x) / pow(r_ij, 2);
					stat.F_p[j].x -= stat.F_p[i].x;

					stat.F_p[i].y += 12 * param.e*(pow(param.R / r_ij, 12) - pow(param.R / r_ij, 6))*(stat.r[i].y - stat.r[j].y) / pow(r_ij, 2);
					stat.F_p[j].y -= stat.F_p[i].y;

					stat.F_p[i].z += 12 * param.e*(pow(param.R / r_ij, 12) - pow(param.R / r_ij, 6))*(stat.r[i].z - stat.r[j].z) / pow(r_ij, 2);
					stat.F_p[j].z -= stat.F_p[i].z;
				}
		
			}
			printf("%d/%d\r",i,param.N);
		}
	printf("\n");
	//--------------------------------------------------------------------
    printf("Hello, OpenCL\n");
    //Setup our GLUT window and OpenGL related things
    //glut callback functions are setup here too
    init_gl(argc, argv);

    //initialize our CL object, this sets up the context
    example = new CL();
    
    //load and build our CL program from the file
    #include "part2.cl" //std::string kernel_source is defined in this file
    example->loadProgram(kernel_source);

    //initialize our particle system with positions, velocities and color
    int num = NUM_PARTICLES;
    std::vector<Vec4> pos(num);
    std::vector<Vec4> color(num);
    std::vector<Vec4> F_p(num);
    std::vector<Vec4> F_s(num);
    std::vector<Vec4> Mom(num);

    //fill our vectors with initial data
    for(int i = 0; i < num; i++)
    {
    	
        pos[i].x = stat.r[i].x;
        pos[i].y = stat.r[i].y;
        pos[i].z = stat.r[i].z;
        pos[i].w = 1.0f;
        
        F_p[i].x = stat.F_p[i].x;
        F_p[i].y = stat.F_p[i].y;
        F_p[i].z = stat.F_p[i].z;
        F_p[i].w = 1.0f;
        
        F_s[i].x = stat.F_s[i].x;
        F_s[i].y = stat.F_s[i].y;
        F_s[i].z = stat.F_s[i].z;
        F_s[i].w = 1.0f;
        
        Mom[i].x = stat.p[i].x;
        Mom[i].y = stat.p[i].y;
        Mom[i].z = stat.p[i].z;
        Mom[i].w = 1.0f;
        
        color[i] = Vec4(1.0f, 0.0f,0.0f, 1.0f);
    }
    
    

    //our load data function sends our initial values to the GPU
    example->loadData(pos, color,  F_p, F_s, Mom);
    //initialize the kernel
    example->popCorn();
    
    //this starts the GLUT program, from here on out everything we want
    //to do needs to be done in glut callback functions
    glutMainLoop();

}


//----------------------------------------------------------------------
void appRender()
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    //this updates the particle system by calling the kernel
    example->runKernel();

    //render the particles from VBOs
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_POINT_SMOOTH);
    glPointSize(5.);
   
    //printf("color buffer\n");
    glBindBuffer(GL_ARRAY_BUFFER, example->c_vbo);
    glColorPointer(4, GL_FLOAT, 0, 0); 

    //printf("vertex buffer\n");
    glBindBuffer(GL_ARRAY_BUFFER, example->p_vbo);
    glVertexPointer(4, GL_FLOAT, 0, 0);

    //printf("enable client state\n");
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);

    //Need to disable these for blender
    glDisableClientState(GL_NORMAL_ARRAY);

    //printf("draw arrays\n");
    glDrawArrays(GL_POINTS, 0, example->num);

    //printf("disable stuff\n");
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
    
    glutSwapBuffers();
}


//----------------------------------------------------------------------
void init_gl(int argc, char** argv)
{

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
    glutInitWindowSize(window_width, window_height);
    glutInitWindowPosition (glutGet(GLUT_SCREEN_WIDTH)/2 - window_width/2, 
                            glutGet(GLUT_SCREEN_HEIGHT)/2 - window_height/2);

    
    std::stringstream ss;
    ss << "Adventures in OpenCL: Part 2, " << NUM_PARTICLES << " particles" << std::ends;
    glutWindowHandle = glutCreateWindow(ss.str().c_str());

    glutDisplayFunc(appRender); //main rendering function
    glutTimerFunc(30, timerCB, 30); //determin a minimum time between frames
    glutKeyboardFunc(appKeyboard);
    glutMouseFunc(appMouse);
    glutMotionFunc(appMotion);

    glewInit();

    glClearColor(0.0, 0.0, 0.0, 1.0);
    glDisable(GL_DEPTH_TEST);

    // viewport
    glViewport(0, 0, window_width, window_height);

    // projection
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(90.0, (GLfloat)window_width / (GLfloat) window_height, 0.1, 1000.0);

    // set view matrix
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0, 0.0, translate_z);

}


//----------------------------------------------------------------------
void appDestroy()
{
    //this makes sure we properly cleanup our OpenCL context
    delete example;
    if(glutWindowHandle)glutDestroyWindow(glutWindowHandle);
    printf("about to exit!\n");

    exit(0);
}


//----------------------------------------------------------------------
void timerCB(int ms)
{
    //this makes sure the appRender function is called every ms miliseconds
    glutTimerFunc(ms, timerCB, ms);
    glutPostRedisplay();
}


//----------------------------------------------------------------------
void appKeyboard(unsigned char key, int x, int y)
{
    //this way we can exit the program cleanly
    switch(key)
    {
        case '\033': // escape quits
        case '\015': // Enter quits    
        case 'Q':    // Q quits
        case 'q':    // q (or escape) quits
            // Cleanup up and quit
            appDestroy();
            break;
    }
}


//----------------------------------------------------------------------
void appMouse(int button, int state, int x, int y)
{
    //handle mouse interaction for rotating/zooming the view
    if (state == GLUT_DOWN) {
        mouse_buttons |= 1<<button;
    } else if (state == GLUT_UP) {
        mouse_buttons = 0;
    }

    mouse_old_x = x;
    mouse_old_y = y;
}


//----------------------------------------------------------------------
void appMotion(int x, int y)
{
    //hanlde the mouse motion for zooming and rotating the view
    float dx, dy;
    dx = x - mouse_old_x;
    dy = y - mouse_old_y;

    if (mouse_buttons & 1) {
        rotate_x += dy * 0.2;
        rotate_y += dx * 0.2;
    } else if (mouse_buttons & 4) {
        translate_z += dy * 0.1;
    }

    mouse_old_x = x;
    mouse_old_y = y;

    // set view matrix
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0, 0.0, translate_z);
    glRotatef(rotate_x, 1.0, 0.0, 0.0);
    glRotatef(rotate_y, 0.0, 1.0, 0.0);
}


