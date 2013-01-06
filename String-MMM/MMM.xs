#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = String::MMM		PACKAGE = String::MMM		

void
match_strings(hidden,target,colors)
	char *hidden;
        char *target;
        int colors;
    INIT:
	 int i;
  	 int blacks = 0;
  	 int whites = 0;
  	 int colors_in_string_h[colors], colors_in_string_t[colors];
    PPCODE:
    for ( i = 0; i < colors; i++ ) {
    	colors_in_string_h[i] =  colors_in_string_t[i] = 0;
    }
    for ( i = 0; i < strlen( hidden ); i++ ) {
    	if ( hidden[i] == target[i] ) {
      	   blacks++;
      	   hidden[i] = target[i] = '.';
    	} else {
      	  colors_in_string_h[hidden[i] - 'A']++;
      	  colors_in_string_t[target[i] - 'A']++;
    	}
    }
    for ( i = 0; i < colors; i ++ ) {
      if ( colors_in_string_h[i] && colors_in_string_t[i] ) {
        whites += ( colors_in_string_h[i] <  colors_in_string_t[i])?
	  colors_in_string_h[i]: colors_in_string_t[i];
       }
    }
    XPUSHs(sv_2mortal(newSViv(blacks)));
    XPUSHs(sv_2mortal(newSViv(whites)));

