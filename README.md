# IPSEPUPPET PROJECT 
==================================================================


Despite the many challenges with the Kinect, P3D, and the Fisca libraries, I was able to 
successfully render a user controllable 3D puppet from a scanned Kinect image. 
The interactive program can be broken down into four main states. 

### Main Menu/Home 

Here, the user will be able to play with the color-less puppet. By clicking the start button, the user will initiate the next state. 

### Scan

In this state, the Kinect will scan the user to extract the full body image of the user. Then user will differentiate the limbs from the body. 
This will help create a clean image to wrap around the 3D puppet. If for some reason the user doesn’t like the outcome their image, they have the option to rescan. 

### Free Play/Practice 

Now the users will be able to see themselves as a 3D puppet! The puppet has the movement and density of a ragdoll. 
Meaning, all of the limbs are extremely loose and flexible. This state gives the user a chance to get comfortable with the puppet’s movement. 
As of now, the movement is controlled via the mouse. The user can click-and-drag the doll from any limb.

### Game 

In this state, the user gets to ruthlessly beat their own puppet! The game rewards the user every time the bat collides with the 3D puppet. 
The user is given 30 seconds to score as many points as they could. 


The game is over once the time is up but they do have the option to play again. 


### Challenges

Our first challenge was actually scanning the users body and extracting the PImage’s of each of their limbs. 
Originally this was going to be an automatic operation done by the program. 
But I thought it would’ve been easier, and the user would’ve preferred, to have the limbs “selected” using the selecting rectangles, which can be seen above.

Our second challenge was actually extracting the images and creating a 3D effect on the puppet using those images. 
Attaching the images to the FBox wasn’t an issue, since there was already a function for that. 
But making it look 3D was difficult, since fisica only works in 2D. 
The way I worked around this was by using the box() function. 
Since I was going for an 8 bit look, I only extracted a pixel every 10 pixels. 
Then I created long 3D boxes with the extracted pixel’s color, which created the 3D effect. 
Basically, I only used the FBox that was designated to each limb as a reference point to put the boxes, so I was still able to use the fisica effects with no problem. 

Last but not least, the Kinect itself. 
Although playing with the Kinect was really fun, there was moments when it would disable the IO of the computer(keyboard and trackpad/mouse), making it completely useless! 
The only solution was to restart the machine every time. This only happened once in a while.

You could check out a video demo [here](https://www.youtube.com/watch?v=h0LGRfBc6Eo)

