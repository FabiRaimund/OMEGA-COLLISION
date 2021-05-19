

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

						    	  WELCOME TO

__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__


						O M E G A     C O L L I S I O N


								- S E N D E R -


"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"


/*


This is your oppertunity to create network-music from code by
sending messages to other players in your network!

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


// You are a SENDER //

// Here you can send messages to other users connected to OSCJunction (or any other network.
// Every message from this file will be transmitted to the corresponding performer using the OMEGA COLLISION RECEIVER code.
// Module/Synth name represented here directly correlates with the Module/Synth name in your RECEIVER's sound-creation-engine: OMEGA COLLISION.

// This generall setup will make you ready as a SENDER and to succesfully transmit messages in 3 simple steps to your RECEIVER (using OSCJunction):

/* 1:	- Use OSCJunction and transfer to a Node and Lobby of your choice [same as your counterpart(s)].
		- Connect to said Lobby under "START SENDING" and enter the Port you and other SENDERS will be sending messages to.
		- For this example we're connecting to OSCJunction's standard Port "57140".
*/

// 2:	- Boot your server!

s.boot;

// 3:	- Address your messages to the correct Port (make sure it is equal to the one you're connected to in OSCJunction):

n = NetAddr("127.0.0.1", 57140);

//	From now on every message corresponding to "n" will be fast forwarded to OSCJunction under Port 57140.
//	If you are running both the OMEGA COLLISION SENDER and RECEIVER on the same machine, refer to the end of this code for additional information regarding setup.

// Also, if you want to control certain Synths via MIDI-Input you shall use the code beneath to activate MIDI-compatibility:


(
MIDIClient.init;
MIDIClient.sources;
MIDIIn.connectAll(verbose: true)
)

//		You're ready to start now!



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						 BEWARE, SYNTHS BELOW!

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//


/*

Each Synth will have a short description referring to important notes,
parameters and potential upsides/downsides.
Please make sure to respect restrictions regarding min/max values,
otherwise the proramm might be unstable, unless...

... that's exactly what you're trying to do. In that case:

We don't hate you,
break our programm,
have fun,
but we won't pay your taxes x)

*/



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						   FABI-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a huge variety of adjustable parameters which can be editet in realtime //

//Sending the message will start a new Synth with given parameters.
/* You may choose between different options, which are:


msg[1] 			= 	Number of loops

msg[2] + msg[3] =	min./max. delay/wait between individual events. (DON'T REDUCE BELOW 0.1)
						if both values are equal: 	delay time between events is fixed.
						if both values are unequal:	randomly choose delay time of the given range.

msg[4] + msg[5] = 	min./max. release time of event.
						if both values are equal: 	realease time is fixed.
						if both values are unequal:	randomly choose a release time of the given range.

msg[6] + msg[7] =	choose your waveform. 0 = Saw, 1 = Pulse, 2 = Sin. (HAS TO BE INTEGER)
						if both values are equal: 	only use according waveform.
						if both values are unequal: randomly choose waveform for each event.

msg[8] + msg[9] = 	min./max. frequency of the synth. (REMEMBER HUMAN RANGE OF AUDIBLE FREQUENCIES)
						if both values are equal:	frequency will be fixed.
						if both values are unequal: randomly choose a frequency of the given range.

msg[10]			=	modulation frequency for a "wobble". (Low values will add "wobble", high values will interfere and add new frequencies)


*/


n.sendMsg("/FSynth1", 20, 0.1, 0.5, 0.2, 10.0, 0, 2, 217.0, 891.0, 0.2);


// You can also send multiple messages with different values at the same time:

(
n.sendMsg("/FSynth1", 72, 0.2, 0.2, 0.3, 0.3, 0, 1, 335.0, 2201.0, 2146);
n.sendMsg("/FSynth1", 5, 1.7, 2.9, 5.0, 7.6, 2, 2, 227.0, 411.0, 6.7);
)


// Using MIDI you can actually play melodies of your desire while also swapping out some parameters beforehand:

(
MIDIdef.noteOn(\JakobnoteOn, {
        arg vel, nn;
        [vel, nn].postln;
        n.sendMsg("/FSynth1", 1, 0.1, 0.5, 0.2, 0.6, 0, 2, nn.midicps, nn.midicps, \vel/2);
});

MIDIdef.noteOff(\JakobnoteOff, {
        arg vel, nn;
        [vel, nn].postln;
		n.sendMsg("/FSynth1", 1, 0.1, 0.5, 0.2, 10.0, 0, 2, nn.midicps, nn.midicps, 0);
});
)


__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	 LUKAS-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a random noise field, subtracted by different Low-Pass and Resonant-Filters, thus creating water-like bubbles or wave-like noise //

/* The following parameters are:


msg[1] + msg[2] =	min./max. volume control. (DON'T USE VALUES ABOVE 25 IN GENERAL)
						if both values are equal: 	amplitude value is fixed.
						if both values are unequal:	randomly choose delay time of the given range.

msg[3] 			=	Cutoff for the first Low-Pass-Filter. (DON'T USE VALUES CLOSE TO 0, OTHERWISE ARTIFACTS AND GLITCHES MAY APPEAR!)

msg[4] 			=	Cutoff for the second Low-Pass-Filter. (DON'T USE VALUES CLOSE TO 0, OTHERWISE ARTIFACTS AND GLITCHES MAY APPEAR!)

msg[5] + msg[6] =	Amplification amount of filters.
						When increasing the bandwidth of frequencies please make sure to also reduce the volume control in msg[1] and msg[2]!
							Doubling the frequencies for example should result in an accordingly similar reduction of volume.

*/


n.sendMsg("/LSynth1_0", 1.0, 2.0, 36.0, 88.0, 200.0, 400.0);

n.sendMsg("/LSynth1_1", 5.0, 7.0, 36.0, 88.0, 200.0, 400.0);

n.sendMsg("/LSynth1_2", 5.0, 7.0, 36.0, 88.0, 600.0, 1400.0);

n.sendMsg("/LSynth1_3", 5.0, 7.0, 11.0, 24.0, 200.0, 400.0);

// These should REALLY be triggered carefully and independently since they are pretty untrustworthy
// Nevertheless triggering some of them together can create amazing effects, so go ahead and be crazy!



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	   BLIP-SYNTH 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a really simple Blip oscillator which can be modified in different ways //

// May always be used to create some kind of uplifting melody while the rest of the crew does random stuff x)
/* You can change these values:


msg[1] 			= 	base frequency of the oscillator

msg[2]  		=	harmony min/start value

msg[3] 			=	harmony max/end value

msg[4] 			= 	speed in which the harmonies are added/run through


msg[5]			=	the general volume control, written as a fader. This value will set the duration after which the value will turn 0.

*/

n.sendMsg("/Blip_0", 77.0, 1.0, 1200.0, 410.0, 10.0);
n.sendMsg("/Blip_1", 223.0, 1.0, 400.0, 200.0, 10.0);
n.sendMsg("/Blip_2", 80.0, 1.0, 400.0, 200.0, 10.0);
n.sendMsg("/Blip_3", 80.0, 1.0, 400.0, 200.0, 10.0);

// You may also want to trigger many of these at once. In that particular case:

(
n.sendMsg("/Blip_0", 77.0, 1.0, 1200.0, 410.0, 10.0);
n.sendMsg("/Blip_1", 223.0, 1.0, 400.0, 200.0, 10.0);
n.sendMsg("/Blip_2", 80.0, 1.0, 400.0, 200.0, 10.0);
n.sendMsg("/Blip_3", 80.0, 1.0, 400.0, 200.0, 10.0);
)


// Using MIDI you can actually play the starting tone but may manually add how many frequencies are added:

(
MIDIdef.noteOn(\JakobnoteOn, {
        arg vel, nn;
        [vel, nn].postln;
        n.sendMsg("/Blip_3", nn.midicps, 1.0, 1200.0, 410.0, vel/10);
});

MIDIdef.noteOff(\JakobnoteOff, {
        arg vel, nn;
        [vel, nn].postln;
		n.sendMsg("/Blip_3", nn.midicps, 1.0, 1200.0, 410.0, 0);
});
)


__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

						  	 LUKAS-SYNTH 2

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features a crazy little feedback-experiment in form of an NDef  //

// You will be sending messages which start the Ndef BUT your RECEIVER may also interact and change the outcome drastically!
/* The following values are adjustable through your messages:

msg[1] 			= 	the Pulse-Generator-Frequency.
						Increasing this value above 750 is dangerous, yet acceptable if:
							msg[2] is reduced at the same time to an equivalent of 1~1/2 of msg[1]. (e.g. 750 and (375-750) works just fine)

msg[2]  		=	the cutoff-frequency of the Band-Pass-Filter.
						Keep annotations from previous message in mind, otherwise instability may occur!

msg[3] 			=	falloff time of initial sweep. (Can be adjusted to individual taste, should be treated very carefully above 2.0)

msg[4] 			= 	reverb time, connected to overall volume.
						Higher reverb times also result in higher overall volume falloff, since the main feedback is meant to exist due to reverblenght, not time itself.



*/

/* BE CAREFUL:

		You should be certain about your action! Otherwise this little devil may quickly get out of hands!
		(Yes... this boy can get VERY loud and NOISY!)
*/


n.sendMsg("/LSynth2", 80.0, 5000.0, 0.9, 7);

// Once you trigger an Ndef of this kind, DON'T instantly trigger another one, unless you want to bring everything to a close end x)
// Since this is a feedback-reliant function you have to witness the power of incredibly fast destruction.



__vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv__

					     	  FABI-SYNTH 2

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//


// This Synth features random impulses, resonators, reverbs and panning, appearing as a very tonal field of different sounds, varying between bell-like shapes and tremoring soundscapes //

// Your messages will form into jitters, chimes, melodies and/or even more!
// This tool will allow you to change values with all sorts of different outcomes BUT they might vary vastly from your expectation!

/* You may modify this beautiful sound-builder by manipulating these values:

msg[1] 			= 	impulse-rate of the modulator.
						Using values between 0 and 75 is best in slot; 0 means that there is no impulse anymore.
						Values above 75 will create a lot of extra noise but mostly through amplitude-overdrive.

msg[2]  		=	base frequency of targeted "chord". (IMPORTANT: This value is represented as MIDI-Input and transformed internally into frequency!)
						The core tune of 440Hz would be MIDI-note 69 for example.

msg[3] 			=	frequencies of overtones/additional harmonies. (IMPORTANT: This This value is represented as MIDI-Input and transformed internally into frequency!)
						One semi-tone (e.g. 69 -> 70) is equivalent to roughly a multiplication by 1.06 in frequency (440Hz -> ~466Hz).
						As with such, adding + 12 in MIDI-notes results in a perfect octave of the base frequency.
							(A value of 7 adds a perfect fifth, a value of 4 a major third, 3 a mninor third, etc.)

msg[4] 			= 	speed of panning between left and right channel.
						At certain speed/high enough values the frequency will become audible and manipulate the sound even further.



*/


// For basic use these messages will be suitable. The result differs but generally comes down to a tonal chord with exceptional attack-behavior!

n.sendMsg("/FSynth2", 50, 45, 6, 0.5);
n.sendMsg("/FSynth2", 0.5, 73, 7, 2.7);


// For advanced uses functions like the one below can prove fitting: Setting the entire process into a randomly chosen pattern adds a nice additional flavour!
(
Task({
	27.do {
		n.sendMsg("/FSynth2", 23, rrand(10, 117), rrand(2, 18), 17);
		rrand(0.1, 0.7).wait;
	};
}).play;
)


// Using MIDI you can actually play every note; the harder you play the note (velocity), the more overtones are added!
// Parameters like the impulses shall be changed manually however (msg[1] and msg[4]):

(
MIDIdef.noteOn(\JakobnoteOn, {
        arg vel, nn;
        [vel, nn].postln;
        n.sendMsg("/FSynth2", 50, nn, vel/10, 0.5);
});

MIDIdef.noteOff(\JakobnoteOff, {
        arg vel, nn;
        [vel, nn].postln;
		n.sendMsg("/FSynth2", 0, nn, vel/10, 0.5);
});
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

