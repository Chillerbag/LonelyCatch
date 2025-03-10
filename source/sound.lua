
-- Bouncing against wall synth
SawSynth = pd.sound.synth.new(pd.sound.kWaveSawtooth)

-- death synth
SquareSynth = pd.sound.synth.new(pd.sound.kWaveNoise)
SquareSynth:setDecay(2)

-- bouncing on paddle synth

-- catching ball synth

-- dashing synth

-- jingle for the intro
SinSynth = pd.sound.synth.new(pd.sound.kWaveSine)
IntroJingle = pd.sound.track.new()
IntroSynth = pd.sound.instrument.new(SinSynth)
IntroJingle:setInstrument(IntroSynth)
IntroJingle:addNote(1, "C4", 1)
IntroJingle:addNote(2, "A#3", 1)
IntroJingle:addNote(3, "Db4", 1)
IntroSequence = pd.sound.sequence.new()
IntroSequence:addTrack(IntroJingle)
IntroSequence:setTempo(12)



