# Wavemaker

This is a little tool for the [Processing](http://processing.org) language/environment.
After starting Processing, open the Wavemaker.pde file.

The tool combines three sine waves into a single wave 
in a linear combination, i.e. each wave
in integrated based on a "weight" (between 0 and 1). A technial detail:
When computing the combined wave the three weights are normalized such that
they add up to 1.

You can modify the three underlying waves using the cursor keys.

![Wavemaker screenshot](wavemaker1.png)

You switch on/off the three underlying waves with the keys 1, 2 and 3.

![Wavemaker screenshot with all three waves visible](wavemaker2.png)
