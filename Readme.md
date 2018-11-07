Spinner
-------

This demo is my first foray into accelerometers.  It is also my first ever 3d graphics code with opengl (although monkey2's mojo3d module makes this a breeze).  The model used for the spinner was hand-crafted (very quickly) in Blender3d and is the first gltf file that I have ever created.  For all of the above reasons, it is a little rough around the edges but I am quite pleased with the result.

It requries an accelerometer to make any sense, although will default to mouse input if an accelerometer is not detected.

Creating this would have been much harder without having Ethernaut's toy plane banana as a starting point (Thank you Ethernaut!) : https://github.com/DoctorWhoof/Plane-Demo

I have also used anatol's Accelerometer class with a few minor tweaks (Thank you anatol!) : https://github.com/anatolbogun/monkey2-utils

Request for Feedback
--------------------

My main motivation for creating this demo is to request people to test it on as many mobile devices as possible.

In particular, I want to be sure that the orientation of the device axes is the same on all devices :
 - Z is perpendicular to the screen
 - X is left-right (when viewing the screen along the Z axis and holding the device horizontally)
 - Y is up-down (ditto)

Please send feedback either via email, or on the monkey2 forums (http://monkeycoder.co.nz/forums/topic/request-for-testing-accelerometer/ ).

Any requests or suggestions for improvements or alterations also very welcome!
