// initialize.ck
// check out score.ck for overview

<<< "Assignment_Final_ItFeelsThatWay" >>>;

Machine.add(me.dir() + "/BPM.ck");
Machine.add(me.dir() + "/song.ck");
Machine.add(me.dir() + "/songmgr.ck");
Machine.add(me.dir() + "/instrument1.ck");

/*
// safe mode - used when editing class files, which if not
// loaded can cause chuck to crash.

// Note: if we get an error like class already loaded, it 
// would be best to stop and start the machine (command-period 2x on mac).  
// Unfortunately, chuck can crash if one of these classes has an issue 
// like a syntax error and doesn't load.  so I have commented this out,
// but feel to uncomment if you run into any issues.
//

int shredId;  // assume 0 means issue with ck file
if(0 == (Machine.add(me.dir() + "/BPM.ck") => shredId))
{
    <<< "error loading instrument1 class" >>>;
    me.exit();
}

if(0 == (Machine.add(me.dir() + "/song.ck") => shredId))
{
    <<< "error loading song class" >>>;
    me.exit();
}
if(0 == (Machine.add(me.dir() + "/songmgr.ck") => shredId))
{
    <<< "error loading songmgr class" >>>;
    me.exit();
}
if(0 == (Machine.add(me.dir() + "/instrument1.ck") => shredId))
{
    <<< "error loading instrument1 class" >>>;
    me.exit();
}
*/

<<< "loaded classes, let's go..." >>>;

// Add score file
Machine.add(me.dir() + "/score.ck");