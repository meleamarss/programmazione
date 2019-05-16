import("stdfaust.lib");

frq = vslider("f [style:knob] [unit:Hz]", 440,100,20000,1); 
pan1 = vslider("pan1 [style:knob]", 0.5,0,1,0.01); 
pan2 = vslider("pan2 [style:knob]", 0.5,0,1,0.01); 
pan3 = vslider("pan3 [style:knob]", 0.5,0,1,0.01); 
pan4 = vslider("pan4 [style:knob]", 0.5,0,1,0.01); 

process = os.oscsin(frq*1), os.oscsin(frq*2), 
          os.oscsin(frq*3), os.oscsin(frq*4) <:
           _ * (sqrt(1-pan1)), _ * (sqrt(1-pan2)),
           _ * (sqrt(1-pan3)), _ * (sqrt(1-pan4)), 
           _ * (sqrt(pan1)), _ * (sqrt(pan2)), 
           _ * (sqrt(pan3)), _ * (sqrt(pan4)) :
           _ + _, _ + _,  _ + _, _ + _ :
           _ + _, _ + _; _ + _, _ + _ : _*(0.25), _*(0.25)
