import("stdfaust.lib");

mastergroup(x) = vgroup("[1]", x);

maingroup(x) = mastergroup(hgroup("[2]", x));

osc1group(x) = maingroup(vgroup("[1] f1", x));
osc2group(x) = maingroup(vgroup("[2] f2", x));
osc3group(x) = maingroup(vgroup("[3] f3", x));
osc4group(x) = maingroup(vgroup("[4] f4", x));

frq = mastergroup(vslider("[1] f [style:knob] [unit:Hz]", 440,100,20000,1)); 

pan1 = osc1group(vslider("[2] pan1 [style:knob]", 0.5,0,1,0.01)); 
pan2 = osc2group(vslider("[2] pan2 [style:knob]", 0.5,0,1,0.01)); 
pan3 = osc3group(vslider("[2] pan3 [style:knob]", 0.5,0,1,0.01)); 
pan4 = osc4group(vslider("[2] pan4 [style:knob]", 0.5,0,1,0.01)); 

vol1 = osc1group(vslider("[3] vol1", 0.0,0.0,1.0,0.01));
vol2 = osc2group(vslider("[3] vol2", 0.0,0.0,1.0,0.01));
vol3 = osc3group(vslider("[3] vol3", 0.0,0.0,1.0,0.01));
vol4 = osc4group(vslider("[3] vol4", 0.0,0.0,1.0,0.01));

process = os.oscsin(frq*1), os.oscsin(frq*2),
          os.oscsin(frq*3), os.oscsin(frq*4) :
          _ * (vol1), _ * (vol2), _ * (vol3), _ * (vol4) <:
          _ * (sqrt(1-pan1)), _ *  (sqrt(1-pan2)), 
          _ * (sqrt(1-pan3)), _ *  (sqrt(1-pan4)),
          _ * (sqrt(pan1)), _ * (sqrt(pan2)),
          _ * (sqrt(pan3)), _ * (sqrt(pan4)) :
          _ + _, _+ _, _+ _, _+ _ :
          _ + _, _+ _ : _ *(0.25), _ *(0.25);		
