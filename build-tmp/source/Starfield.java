import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Starfield extends PApplet {

int frameCount = 0;

Particle [] ichi;

public void setup()
{
	size(600,600);
	background(0);

	ichi = new Particle[101];
	for(int i = 0; i < ichi.length; i++)
	{
		if(i == 0)
		{
			ichi[i] = new OddballParticle();
		}
		else
		{
			ichi[i] = new NormalParticle();
		}
	}
}
public void draw()
{
	if( !(frameCount > 5))
	{
		frameCount++;
	}

	fill(0,0,0,12);
	rect(-10,-10,width+100,height+100);
	for(int i = 0; i < ichi.length; i++)
	{
		ichi[i].move();
		ichi[i].show();

		// if(frameCount > 5)
		// {
		// 	if(dist( (float)ichi[i].myX,(float)ichi[i].myY, 300,300) <= ichi[i].mySpeed/2)
		// 	{
		// 		println("ichi[" + i + "] turn");
		// 	}
		// }
	}
}
class NormalParticle implements Particle
{
	double myX, myY, mySpeed, myAngle;
	int myColor;
	boolean orientation;

	NormalParticle()
	{
		myColor = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
		myX = width/2;
		myY = height/2;

		mySpeed = Math.random()*4;
		myAngle = Math.random()*2*Math.PI;
		orientation = false;
	}

	public void move()
	{
		myX += (Math.cos(myAngle) * mySpeed);
		myY += (Math.sin(myAngle) * mySpeed);
		
		if(frameCount > 5)
		{
			if(dist( (float)myX,(float)myY, 300,300) <= mySpeed/2)
			{
				orientation = !orientation;
			}
		}

		if(orientation)
		{
			myAngle -= 0.02f;
		}
		else 
		{
			myAngle += 0.02f;	
		}
	}

	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,5,5);
	}

} //the pink bar was bothering me

interface Particle
{
	public void move();
	public void show();
} //the pink bar was bothering me

class OddballParticle implements Particle
{
	double myX, myY, mySpeed, myAngle;
	int myColor;

	OddballParticle()
	{
		myColor = color(255,255,255);
		myX = width/2;
		myY = height/2;
		mySpeed = (Math.random()*8)+(Math.random()*3);
		myAngle = Math.random()*2*Math.PI;
	}

	public void move()
	{
		if(Math.random() > 0.5f)
		{
			myX += ( Math.cos(myAngle) * mySpeed);
		}
		else
		{
			myX -= ( Math.cos(myAngle) * mySpeed);
		}
		if(Math.random() > 0.5f)
		{
			myY += ( Math.sin(myAngle) * mySpeed);
		}
		else
		{
			myY -= ( Math.sin(myAngle) * mySpeed);
		}
		myAngle = Math.random()*2*Math.PI;
	}

	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,7,7);
	}
} //the pink bar was bothering me


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Starfield" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
