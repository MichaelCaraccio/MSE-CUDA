#include "Indice2D.h"
#include "cudaTools.h"
#include "Device.h"

#include "RayTracingCMMath.h"
#include "IndiceTools.h"
#include "Sphere.h"

/*----------------------------------------------------------------------*\
 |*			Declaration 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

__global__ void raytracingCM(uchar4* ptrDevPixels, Sphere* ptrDevSphere, int nbSphere, int w, int h, float t);

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

/*----------------------------------------------------------------------*\
 |*			Implementation 					*|
 \*---------------------------------------------------------------------*/

/*--------------------------------------*\
 |*		Public			*|
 \*-------------------------------------*/

/*--------------------------------------*\
 |*		Private			*|
 \*-------------------------------------*/

__global__ void raytracingCM(uchar4* ptrDevPixels, Sphere* ptrDevSphere, int nbSphere, int w, int h, float t)
    {
    RayTracingCMMath rayTracingCMMath = RayTracingCMMath(t); // ici pour preparer cuda

    const int WH = w * h;

    const int NB_THREAD = Indice2D::nbThread();
    const int TID = Indice2D::tid();

    int s = TID;

    int i;
    int j;
    while (s < WH)
	{
	IndiceTools::toIJ(s, w, &i, &j);
	rayTracingCMMath.colorXY(&ptrDevPixels[s],ptrDevSphere,nbSphere, i,j,t);
	s += NB_THREAD;
	}
    }

/*----------------------------------------------------------------------*\
 |*			End	 					*|
 \*---------------------------------------------------------------------*/

