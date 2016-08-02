#define STRINGIFY(A) #A

std::string kernel_source = STRINGIFY(
__kernel void part2(
__global float4* pos,  __global float4* color, __global float4* F_p, __global float4* F_s, __global float4* Mom ,float tau, float R, float e, float L, float f, float m)
{

//get our index in the array
unsigned int i = get_global_id(0);
unsigned int j = get_global_id(1);

//copy position and velocity for this iteration to a local variable
//note: if we were doing many more calculations we would want to have opencl
//copy to a local memory array to speed up memory access (this will be the subject of a later tutorial)
float4 p_i = pos[i];
float4 p_j = pos[j];
float4 fp = F_p[i];
float4 fs = F_s[i];
float4 mom= Mom[i];
float4 col = color[i];
mom += (fp + fs)*tau/2.0f; 

p_i.x += mom.x*tau / m;
p_i.y += mom.y*tau / m;
p_i.z += mom.z*tau / m;

p_j.x += mom.x*tau / m;
p_j.y += mom.y*tau / m;
p_j.z += mom.z*tau / m;

fs=0;
fp=0;

mom.w = sqrt(pow(mom.x,2)+pow(mom.y,2)+pow(mom.z,2));
col.x = mom.w/.4f;
col.y = .3f;
col.z = .3f;
if(mom.w>=.4f)
	mom=0;

mom.w = sqrt(pow(p_i.x,2)+pow(p_i.y,2)+pow(p_i.z,2));
if (mom.w>= L)
{
    fs += f*(L - mom.w)* p_i / mom.w;
}

if(i!=j)
{
    mom.w = sqrt(pow(p_i.x - p_j.x, 2) + pow(p_i.y - p_j.y, 2) + pow(p_i.z - p_j.z, 2));
        
    fp += 12 * e*(pow(R / mom.w, 12) - pow(R / mom.w, 6))*(p_i - p_j) / pow(mom.w, 2);
}

mom += (fp+fs)*tau / 2.0f;

//update the arrays with our newly computed values
pos[i] = p_i;
F_p[i] = fp;
F_s[i]  = fs;
Mom[i]  = mom;
color[i] = col;
}
);
