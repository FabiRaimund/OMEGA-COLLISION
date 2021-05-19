

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

						    	  WELCOME TO

__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__


						O M E G A     C O L L I S I O N


							  - R E C E I V E R -


"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"


/*

This is your oppertunity to create network-music from code by
receiving messages from other players in your network and also
adjusting their input-outcome through your own interference!

This network was first performed and built by:

	Fabian Raimund:		creating and collecting SuperCollider-code/-synths, making everything viable for OSCJunction
	Lukas Körfer: 		sound-reactive visuals in Hydra and ensuring OSCJunction compatibility, creating synths too
	Jakob Gertheiss: 	streaming consultor and performance overseer, setting up MIDI-, aswell as general, input and mood
	Fabian Schmidt: 	final streaming, executing and controlling the code under performance, being a tech-nerd :P


And now?
What are you waiting for?!

Go ahead and have fun being creative!


*/



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

							 GENERAL SETUP

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// You are a RECEIVER //

// Here you will be running the main sound-creation-engine OMEGA COLLISION.
// Every message yo receive was sent from other users connected to OSCJunction (or any other network)
// Module/Synth name represented here directly correlates with the Module/Synth name in your SENDER's code.

// This generall setup will make you ready as a RECEIVER and to succesfully convert messages into sound (using OSCJunction):

// 1:	- Boot your server!

s.boot;

// 2:	- Use OSCJunction and transfer to a Node and Lobby of your choice [same as your counterpart(s)]
//		- Connect to said Lobby under "START RECEIVING" and enter your local sclang Port:

NetAddr.langPort;

// standard: 57120. Sometimes this number may vary, therefor using above code is necessary. You can then find your local Port in the Post window/Terminal after executing.

//	From now on every message sent to Port 57140 of your corresponding note in OSCJunction will be directly transmissioned towards you and trigger certain synths, etc.
//	If you are running both the OMEGA COLLISION RECEIVER and SENDER on the same machine, refer to the end of this code for additional information regarding setup.

//		You're ready to start now! However, some additionally helpful tools are still required to guarantee the best experience and interactivity:


(
s.meter;
s.scope;
s.freqscope;
NdefMixer(s);
)

// Also, as a reminder: in order to make this project fully performable you first need to start and execute every Synth below by hand, sorry :P

// However, once you've loaded these and adjusted the helpful tools on your screen(s), you and your mates are finally ready to enjoy the full capabilities of OMEGA COLLISION!




__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						   FABI-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

// This Synth features a huge variety of adjustable parameters which can be editet in realtime //



(
SynthDef(\Chooser, {|freq = 400, rt = 10.0, choose = 0, wob_mod = 0.2|
	var snd, bank, env;
	bank = [Saw.ar([freq, freq], mul: 0.5), Pulse.ar([freq, freq], mul: 0.5), SinOsc.ar([freq, freq], mul: 0.5)];
	env = EnvGen.ar(Env.perc(0.01, rt), doneAction: 2);
	snd = Select.ar(choose, bank);
	Out.ar(0, snd * SinOsc.ar(wob_mod) * env);
}).add;
);

(
OSCdef(\Chooser, {|msg|
	msg.postln;
	Task({
		msg[1].do {

			x = Synth(\Chooser);
			r = rrand(msg[4], msg[5]);
			c = rrand(msg[6], msg[7]);
			a = rrand(msg[8], msg[9]);
			x.set(\rt, r);
			x.set(\choose, c);
			x.set(\freq, a);
			x.set(\wob_mod, msg[10]);
			rrand(msg[2], msg[3]).wait;
		};
	}).play;
}, '/FSynth1');
);




__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	 LUKAS-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a random noise field, subtracted by different Low-Pass and Resonant-Filters, thus creating water-like bubbles or wave-like noise //


(
(
SynthDef(\blub, { | sus = 1, pan = 1, amp = 10, lpfreq1 = 14, lpfreq2 = 20, freqamp1 = 400, freqamp2 = 800 |
    var blub1, blub2, env;
    blub1 = RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, lpfreq1) * freqamp1 + 500, 0.03, 0.003);
    blub2 = (RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, lpfreq2) * freqamp2 + 1000, 0.03, 0.005)) * 4;
    env = EnvGen.ar(Env([0.1, 1, 0.9, 0.9, 0], [0.8, 0.1, sus, 1], \wel), doneAction: 2);
	Out.ar(0, (Pan2.ar((blub1 + blub2) * env, pan)) * amp);
}).add;
);

(
OSCdef(\LSynth1_0, {|msg|
	Task({
		3.do {
			Synth(\blub, [\sus, List[2.5, 3.5].at(2.rand), \pan, 1.sum3rand , \amp, rrand(msg[1], msg[2]), \lpfreq1, msg[3], \lpfreq2, msg[4], \freqamp1, msg[5], \freqamp2, msg[6]]);
        rrand(3, 6).wait;
    };
}).play;
}, '/LSynth1_0');

OSCdef(\LSynth1_1, {|msg|
	Task({
		3.do {
			Synth(\blub, [\sus, List[2.5, 3.5].at(2.rand), \pan, 1.sum3rand , \amp, rrand(msg[1], msg[2]), \lpfreq1, msg[3], \lpfreq2, msg[4], \freqamp1, msg[5], \freqamp2, msg[6]]);
        rrand(3, 6).wait;
    };
}).play;
}, '/LSynth1_1');

OSCdef(\LSynth1_2, {|msg|
	Task({
		3.do {
			Synth(\blub, [\sus, List[2.5, 3.5].at(2.rand), \pan, 1.sum3rand , \amp, rrand(msg[1], msg[2]), \lpfreq1, msg[3], \lpfreq2, msg[4], \freqamp1, msg[5], \freqamp2, msg[6]]);
        rrand(3, 6).wait;
    };
}).play;
}, '/LSynth1_2');
OSCdef(\LSynth1_3, {|msg|
	Task({
		3.do {
			Synth(\blub, [\sus, List[2.5, 3.5].at(2.rand), \pan, 1.sum3rand , \amp, rrand(msg[1], msg[2]), \lpfreq1, msg[3], \lpfreq2, msg[4], \freqamp1, msg[5], \freqamp2, msg[6]]);
        rrand(3, 6).wait;
    };
}).play;
}, '/LSynth1_3');
);
)


__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	   BLIP-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a really simple Blip oscillator which can be modified in different ways //


(
(
SynthDef(\Blip, {|bfreq = 200.0, harm_start = 1.0, harm_end = 400.0, harm_speed = 200.0, fade_time = 10.0|
	var snd;
	snd = Blip.ar(bfreq, Line.kr(harm_start, harm_end, harm_speed));
	Out.ar(0, snd.dup * XLine.kr(0.2, 0.001, fade_time, doneAction: 2));
}).add;
);

(
OSCdef(\Blip_0, {|msg|
	Synth(\Blip, [\bfreq, msg[1], \harm_start, msg[2], \harm_end, msg[3], \harm_speed, msg[4], \fade_time, msg[5]]);
}, '/Blip_0');
OSCdef(\Blip_1, {|msg|
	Synth(\Blip, [\bfreq, msg[1], \harm_start, msg[2], \harm_end, msg[3], \harm_speed, msg[4], \fade_time, msg[5]]);
}, '/Blip_1');
OSCdef(\Blip_2, {|msg|
	Synth(\Blip, [\bfreq, msg[1], \harm_start, msg[2], \harm_end, msg[3], \harm_speed, msg[4], \fade_time, msg[5]]);
}, '/Blip_2');
OSCdef(\Blip_3, {|msg|
	Synth(\Blip, [\bfreq, msg[1], \harm_start, msg[2], \harm_end, msg[3], \harm_speed, msg[4], \fade_time, msg[5]]);
}, '/Blip_3');
);
)



// The following two synths will be programmed as Ndefs so the RECEIVER may also take part in the performance by adjusting the values using the NdefMixer or other functionalities //




__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	 LUKAS-SYNTH 2

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a crazy little feedback-experiment in form of an NDef//

// To run this Synth you first need to install the Feebdack Quark from the Quarks gui. You may start it here:

Quarks.gui;


// YOU can play with this Ndef once you receive a message from your SENDERS

// By pressing and/or holding your mouse you can shift the frequency of the feedback upwards, while the Ndef is playing
// By moving your mouse up and down on the screen you can increase the rate of the Stereo-Panning
// Make sure you know the potential variety of sound this Ndef can produce so you can interact with your SENDERS once they trigger it!


/* BE CAREFUL:

		You should be certain about your action! Otherwise this little devil may quickly get out of hands!
		Always make sure you have the NdefMixer running alongside OMEGA COLLISION so you're able to adjust every outcome which is (not) suitable for the performance...
		(Yes... this boy can get VERY loud and NOISY!)
*/


(
OSCdef(\quarksB, {|msg|
	Ndef(\quarksFB, {
		var sig, f, rev, out;
		sig = BPF.ar(Pulse.ar(msg[1]), msg[2], 0.2) * Line.kr(1, 0, msg[3]);
		f = Fb({ |fb| FreqShift.ar(fb + sig, MouseButton.kr(-4, 5))});
		rev = JPverb.ar(f, msg[4]);
		out = Pan2.ar(rev[1], FSinOsc.kr(MouseY.kr(0.2, 10)));
		(out * Line.kr(0.2, 0.0, msg[4]*2, doneAction: 2)).tanh;
	}).play;
}, '/LSynth2');
)




__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

					     	  FABI-SYNTH 2

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features random impulses, resonators, reverbs and panning, appearing as a very tonal field of different sounds, varying between bell-like shapes and tremoring soundscapes //


(
(
Ndef(\mod, { | amp = 0.5, rate = 50 |

	Decay2.ar(Dust.ar(rate), 0.01, 0.04);
});

Ndef(\sub, { | amp = 0.3, dist = 1, sinkr = 10 |

	var decay, source, num_flt, freqs, amps, rings, filter_bank, snd;


	decay = Ndef(\mod);


	source = PinkNoise.ar() * decay * 0.01;

	num_flt = 10;

	freqs = \freqs.kr(Array.series(num_flt, 45, 6).midicps);
	amps = \amps.kr(Array.fill(num_flt, { 1; }));
	rings = \rings.kr(Array.fill(num_flt, { 1; }));

	filter_bank = DynKlank.ar(`[freqs, amps, rings], source);

	snd = GVerb.ar(filter_bank * 0.4, 150, 10).sum * amp;

	snd = (snd.sum * dist).distort !2;

	snd = Pan2.ar(snd.sum, SinOsc.kr(sinkr));
});

Ndef(\sub).fadeTime = 2;
);



(
OSCdef(\FSynth2, {|msg|
	Ndef(\mod).set(\rate, msg[1]);
	Ndef(\sub).set(\freqs, Array.series(10, msg[2], msg[3]).midicps);
	Ndef(\sub).set(\sinkr, msg[4]);
	Ndef(\sub).play;
}, '/FSynth2');
);
)



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						   ADDITIONAL INFORMATION

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// Here you can find additional notes in case you are running into troube or using the code in different manner:


/*	In case you are running both the OMEGA COLLISION and SENDER FILE on the same machine and/or
	or want to try the functionailty/execution of your code without using OSCJunction or any other networking tool:

		Swapping your Port to your local scsynth/lang will prove valuable.

	In order to run your work locally you can use the following code to immediatley switch to a local execution:
*/

NetAddr.langPort;

// refer to your Post window/terminal and swap the current Port-number (57140) with the one you received using this method. Standard value: 57120, may change after recompiling or crashes.
// It may look like this:

n = NetAddr("127.0.0.1", 57120);

// Now just return to the code above and enjoy playing with OMEGA COLLISION (locally)! ;)


// In case your system runs into trouble or the server crashes, rebooting the server may prove efficient:

s.reboot;




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

						     THANK YOU FOR USING

__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__


						O M E G A     C O L L I S I O N


"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"