// drums.ck
//<<< "Assignment_Final_ItFeelsThatWay" >>>;

<<< "enter drumz" >>>;

0 => int kickID;
1 => int snareID;
2 => int hihatID;

SongMgr mgr1;
mgr1.setSong(Song s);

Instrument1 i1, i2, i3;
mgr1.getParams(kickID) @=> i1.params;
i1.initInstrument(me.dir(-1) + "/audio/" + "kick_01" + ".wav");

mgr1.getParams(snareID) @=> i2.params;
i2.initInstrument(me.dir(-1) + "/audio/" + "snare_01" + ".wav");

mgr1.getParams(hihatID) @=> i3.params;
i3.initInstrument(me.dir(-1) + "/audio/" + "hihat_01" + ".wav");


fun void play(Instrument1 instr, int ID)
{
    0 => int counter;
    while(true)
    {
        if(!instr.isPlayingPattern) {
            if(mgr1.getNextLoopType(ID) != -1)
                mgr1.getHitPattern(ID) @=> instr.pattern;
            mgr1.getParams(ID) @=> instr.params;
        }
        
        instr.processEvents(mgr1);
        instr.play(counter);        

        mgr1.getChuck(ID) => now;
        counter++;   
    }

}

spork ~ play(i1, kickID);
spork ~ play(i2, snareID);
spork ~ play(i3, hihatID);


while(true) { 1::second => now;}  // parent waits

