/*

    This file is part of the project txt2pho.
    The project is released under the AGPL 3.0 license.
    For details concerning the resulting rights and
    conditions of this license see file License.txt.

*/

/*********************************************************
    i.h
    --------------------------------------------------------
    generated at Thu Jun 18 17:52:41 1998
    by snns2c ( Bernward Kett 1995 )
*********************************************************/

extern "C" int i(float* in, float* out, int init);

static struct
{
    int NoOfInput;    /* Number of Input Units  */
    int NoOfOutput;   /* Number of Output Units */
    int(* propFunc)(float*, float*, int);
} iREC = {30, 1, i};
