import("stdfaust.lib");


vmeter(x) = attach(x, envelop(x) : vbargraph("[03][unit:dB]", -70, +5)) 
with{
    envelop   = abs : max ~ -(1.0/ma.SR) : max(ba.db2linear(-70)) : ba.linear2db;
};

oscill(o) = os.oscsin(frq*avo): hgroup("[02] OSC %avo", *(vol)<: * (sqrt(1-pan)), * (sqrt(pan)) : vmeter, vmeter)
  with{
    avo = o+(001);
    oscgroup(x)  = vgroup("[02] f1", x);
    frq  = vslider("[01] FREQ [style:knob] [unit:Hz]", 440,100,20000,1); 
    pan = oscgroup(vslider("[01] PAN [style:knob]", 0.5,0,1,0.01)); 
    vol = oscgroup(vslider("[02] VOL", 0.0,0.0,1.0,0.01));   
};

stereo = hgroup("[127] STEREO OUT", *(vol), *(vol) : vmeter, vmeter)
  with{
    vol = vslider("[01] VOL", 0, -70, 6, 0.1) : ba.db2linear : si.smoo;
};
 
process = hgroup("OSCILLATORS BANK", par(i, 4, oscill(i)) :> stereo);
//numerazione che parta da 1 
//la moltiplicazione che parta da 1
