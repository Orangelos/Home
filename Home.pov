/*
За основу взята первая лаба: Добавлено ночное небо, луна, а также теперь фонари все прозрачные(это видно на 2 камере)
 */
 
 
 #include "colors.inc"   
 
 
 camera {
 angle 100
 location <27,10,0> 
 look_at 0 
} 


/*
 camera {
 angle 100
 location <16,6,-5> 
 look_at 0 
}
*/ 
sky_sphere {
    pigment {
        gradient y
        color_map {
            [0.0 color rgb <0.0, 0.0, 0.1>]
            [1.0 color rgb <0.0, 0.0, 0.0>]
        }
        scale 0.5
    }
}

sky_sphere {
    pigment {
        bozo
        scale 0.005
        color_map {
            [0.0  color rgb <0,0,0>]
            [0.7  color rgb <0,0,0>]
            [0.71 color rgb <1,1,1>]
            [1.0  color rgb <1,1,1>]
        }
        warp { turbulence 1.5 }
    }
    
}
  plane {
    y, 0
    pigment { color rgb <0.05, 0.2, 0.05> } 
} 
  
sphere {
    <5, 15, -5>, 1
    texture {
        pigment { color rgbf <1, 1, 1,0.5> } // Белая луна
        finish {
            ambient 0.5 
            diffuse 0.5
        }
    }
}


difference {
    
    box {
        <-5, 0, -5>, <5, 5, 5>  
        texture {
            pigment {checker
    rgb <1, 0.25, 0.1>, rgb <0.7, 0.2, 0.1>
     scale 0.3 }  
        }
    }
    

    box {
        <5.05, 0, -1>, <4.99, 3, 1>  
        texture {
            pigment { color rgb <0.3, 0.2, 0.1>  } 
            finish {
                phong 0.6  
            }
        }
    }


    union {
    box {
        <5.01, 2, -4>, <4.9, 4, -2>  
        texture {
            pigment { rgbf <1, 1, 1, 0.5> }  
            finish { reflection 0.1 }
        }
    }  
}
}

// Дорога
box {
    <15, 0, 25>, <18, 0.5, -19>
    texture {
        pigment {
            color rgb <0.1, 0.1, 0.1> 
        }
        finish {
            diffuse 0.6
            specular 0.1
        }
    }
}
#declare Line_Spacing = 4; 
#declare Line_Length = 2; 
#declare Line_Width = 0.2; 
#declare Z_Pos = 25;

#while (Z_Pos > -19)
    box {
        <16.5 - Line_Width/2, 0.51, Z_Pos - Line_Length/2>,
        <16.5 + Line_Width/2, 0.52, Z_Pos + Line_Length/2>
        texture {
            pigment { color White }
            finish {
                diffuse 0.9
                specular 0.5
            }
        }
    }
    #declare Z_Pos = Z_Pos - (Line_Length + Line_Spacing);
#end


#declare Street_Lamp = union {

    cylinder {
        <0, 0, 0>, <0, 6, 0>, 0.1
        texture { pigment { color Brown } }
    }
     /*
    sphere {
        <0, 6, 0>, 0.2
        texture { pigment { rgbf<1,1,1,0.8> } }
        finish { emission 1 }
    } 
    */
    lathe {   
          
    cubic_spline
     8
     <-1,1>, <0, 1>, <3, 1>, <3,6>, <4, 6>, <4, 0>, <0, 0>, <-1, 0>

      translate <0, 60, 0>  
      scale 0.1
    texture { 
        
       pigment { rgbf <1, 1, 0.6, 0.3> }
       finish { 
           ambient 0.1
           diffuse 0.7
           specular 0.5
           reflection 0.3
         }
    }  
    }

    light_source {
        <0, 8, 0>
        color rgb <1,1,0.8>*0.3
    }
}


#declare Lamp_Spacing = 10;
#declare Lamp_Pos = 25;

#while (Lamp_Pos > -19)
    // Левый фонарь и его источник света
    object {
        Street_Lamp
        translate <15, 0, Lamp_Pos>
    }
    light_source {
        <15, 6, Lamp_Pos>
        color rgb <1,1,0.8>*0.5
    }

    // Правый фонарь и его источник света
    object {
        Street_Lamp
        translate <18, 0, Lamp_Pos>
    }
    light_source {
        <18.4, 6, Lamp_Pos>
        color rgb <1,1,0.8>*0.5
    }
         
         
         
         
    #declare Lamp_Pos = Lamp_Pos - Lamp_Spacing;
#end

union {
    cylinder {
        <9, 0, 9>, <9, 5, 9>, 0.5  
        texture { pigment { color Brown } }  
      
        }
    
     
         sphere { 
        <9, 6, 9>, 2  
        texture { pigment { rgbf<0,1,0> } }  
    
       
   }    
    
      
      
     
}
      

    
  





   
union {
    
    triangle {
        <-5, 5, -5>, <5, 5, -5>, <0, 8, 0>
    }
    triangle {
        <-5, 5, 5>, <5, 5, 5>, <0, 8, 0>
    }
    triangle {
        <-5, 5, -5>, <-5, 5, 5>, <0, 8, 0>
    }
    triangle {
        <5, 5, -5>, <5, 5, 5>, <0, 8, 0>
    }
    texture {
        pigment {  color rgb <0.3, 0.2, 0.1> }
        finish {
            ambient 0.2
            diffuse 0.7
        }
    }
}   
#declare FenceHeight = 4;
#declare FenceWidth = 2;         
#declare FenceThickness = 0.2;    
#declare FenceColor = color rgb <0.3, 0.2, 0.1>;

#declare SlatHeight = 0.2; 
#declare SlatGap = 0.2;    

#declare HouseWidth = 4;   
#declare HouseLength = 4;  
#declare HouseHeight = 3;  

#declare HousePosition = <0, 0, 0>; 

object {
    box {
        <-HouseWidth/2, 0, -HouseLength/2>, <HouseWidth/2, 5, HouseLength/2>
        texture {
            pigment { color rgb <1.1, 0.2, 0.1> }
        }
    }
}

#declare FenceSection = union {
    box {
        <-FenceWidth/2, 0, -FenceThickness/2>, <FenceWidth/2, SlatHeight, FenceThickness/2>
        texture {
            pigment { FenceColor }
        }
    }
};

#local Y = 0;
#while (Y < FenceHeight)
    #local X = -HouseWidth/2 - FenceWidth - 3; 
    #while (X <= HouseWidth/2 + FenceWidth + 3) 
        object {
            FenceSection
            translate <X, Y, -HouseLength/2 - FenceThickness - 5> 
        }
        #local X = X + FenceWidth;
    #end
    #local X = -HouseWidth/2 - FenceWidth - 3; 
    #while (X <= HouseWidth/2 + FenceWidth + 3) 
        object {
            FenceSection
            translate <X, Y, HouseLength/2 + FenceThickness + 5 > 
        }
        #local X = X + FenceWidth;
    #end
    #local Z = -HouseLength/2 - FenceWidth - 3; 
    #while (Z <= HouseLength/2 + FenceWidth + 3) 
        object {
            FenceSection
            rotate <0, 90, 0>
            translate <-HouseWidth/2 - FenceThickness - 5, Y, Z> 
        }
        #local Z = Z + FenceWidth;
    #end
    #local Z = -HouseLength/2 - FenceWidth - 3; 
    #while (Z <= HouseLength/2 + FenceWidth + 3) 
        object {
            FenceSection
            rotate <0, 90, 0>
            translate <HouseWidth/2 + FenceThickness + 5, Y, Z> 
        }
        #local Z = Z + FenceWidth;
    #end

    #local Y = Y + SlatHeight + SlatGap;
#end

#declare RailThickness = 0.4;
#declare RailHeight = FenceHeight;

#declare RailSection = union {
    box {
        <-RailThickness/2, 0, -RailThickness/2>, <RailThickness/2, RailHeight, RailThickness/2>
        texture {
            pigment { FenceColor }
        }
    }
};

object {
    RailSection
    translate <-HouseWidth/2 - FenceThickness - 5, 0, -HouseLength/2 - FenceThickness - 5>  
}

object {
    RailSection
    translate <HouseWidth/2 + FenceThickness + 5, 0, -HouseLength/2 - FenceThickness - 5>  
} 
object {
    RailSection
    translate <-HouseWidth/2 - FenceThickness - 5, 0, HouseLength/2 + FenceThickness + 5>  
}

object {
    RailSection
    translate <HouseWidth/2 + FenceThickness + 5, 0, HouseLength/2 + FenceThickness + 5>  
}  

#declare CentralPostThickness = 0.4; 
#declare CentralPostHeight = 4;      

#declare CentralPost = union {
    box {
        <-CentralPostThickness/2, 0, -CentralPostThickness/2>, 
        <CentralPostThickness/2, CentralPostHeight, CentralPostThickness/2>
        texture {
            pigment { FenceColor }
        }
    }
}; 



/*// Дорога
box {
    <15, 0, 25>, <18, 0.5, -19>
    texture {
        pigment {
            color rgb <0.1, 0.1, 0.1> 
        }
        finish {
            diffuse 0.6
            specular 0.1
        }
    }
}
*/
       



#declare YL=30;   
#while(YL>-15)  


sphere_sweep {
b_spline, 10
  <18, -20, YL>, .1
  <18.3, 1, YL>, .1
  <18.6, 2, YL>, .1  
  <18.3, 3, YL>, .1 
  <18, 4, YL>, .1  
  <15, 4, YL>, .1 
  <14.7, 3, YL>, .1
  <14.4, 2, YL>, .1
  <14.7, 1, YL>, .1 
  <15, -20, YL>, .1 
  pigment {rgbf <0.7, 0, 0.2, 0.5> }
} 
  #declare YL=YL-3;
 #end


 