int frameCount = 0;
boolean trail = true;

Particle [] ichi;

interface Particle
{
	public void redo();
	public void move();
	public void show();
}

void setup()
{
	size(900,600);
	background(0);

	ichi = new Particle[601];
	for(int i = 0; i < ichi.length; i++)
	{
		if(i == ichi.length-1)
		{
			ichi[i] = new OddballParticle();
		}
		else if(i == ichi.length-2)
		{
			ichi[i] = new Jumbo();
		}
		else
		{
			ichi[i] = new NormalParticle();
		}
	}
}

void draw()
{
	frameCount++;

	if(trail)
	{
		fill(0,0,0,15);
		rect(-10,-10,width+100,height+100);
	}
	else
	{
		background(0);
	}

	for(int i = 0; i < ichi.length; i++)
	{
		ichi[i].move();
		ichi[i].show();
	}
}

void keyPressed()
{
	if(key == 'a')
	{
		trail = !trail;
	}

	if(key == 's')
	{
		for(int i = 0; i < ichi.length; i++)
		{

			ichi[i].redo();
		}
	}
}

class NormalParticle implements Particle
{
	double myX, myY, mySpeed, myAngle;
	int myColor;
	boolean orientation;
	boolean swirl;

	NormalParticle()
	{
		myColor = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
		myX = width/2;
		myY = height/2;

		mySpeed = Math.random()*4;
		myAngle = Math.random()*2*Math.PI;
		orientation = false;
		swirl = true;
	}

	public void redo()
	{
		myColor = color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
		myX = width/2;
		myY = height/2;

		mySpeed = Math.random()*4.5;
		myAngle = Math.random()*2*Math.PI;
		swirl = !swirl;
		if(swirl)
		{
			orientation = !orientation;
		}
	}

	public void move()
	{
		myX += (Math.cos(myAngle) * mySpeed);
		myY += (Math.sin(myAngle) * mySpeed);
		
		if(frameCount > 5)
		{
			if(dist( (float)myX,(float)myY, width/2,height/2) <= mySpeed/2)
			{
				orientation = !orientation;
			}
		}
		
		if(swirl)
	    {
	    	if(orientation)
			{
				myAngle -= 0.02;
			}
			else 
			{		
				myAngle += 0.02;	
			}
		}
	}

	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,3,3);
	}
}

class Jumbo extends NormalParticle
{
	Jumbo()
	{

	}
	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,20,20);
	}
}

class OddballParticle implements Particle
{
	double myX, myY, mySpeed, myAngle;
	double oldX, oldY;
	int myColor, mySize;
	boolean sizeChange;

	OddballParticle()
	{
		myColor = color(255,255,255);
		myX = width/2;
		myY = height/2;
		mySpeed = (Math.random()*3)+(Math.random()*4);
		myAngle = Math.random()*2*Math.PI;
		mySize = 10;
		sizeChange = true;
	}

	public void redo()
	{
		
	}

	public void move()
	{
		oldX = myX;
		oldY = myY;

		int randomPause = ((int)(Math.random()*3)+1)*5;

		myX += (2*(Math.cos(myAngle) * mySpeed)) - (Math.cos(myAngle) * mySpeed);
		myY += (2*(Math.sin(myAngle) * mySpeed)) - (Math.sin(myAngle) * mySpeed);

		if(frameCount%randomPause == 0)
		{
			myAngle = Math.random()*2*Math.PI;
		}

		// if(myX > width || myX < 0 )
		if(myX + mySize > width || myX - mySize < 0)
		{
			myAngle = Math.PI - myAngle;
		}
		// if(myY > height || myY < 0)
		if(myY + mySize > height || myY - mySize < 0)
		{
			myAngle = -1 * myAngle;
		}

		if(frameCount%90 == 0)
		{
			sizeChange = !sizeChange;
		}

	}

	public void show()
	{
		if(frameCount%3 == 0)
		{
			if(sizeChange)
			{
				mySize++;
			}
			else
			{
				mySize--;	
			}
		}

		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,mySize,mySize);	
	}
}