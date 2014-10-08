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
	size(600,600);
	background(0);

	ichi = new Particle[301];
	for(int i = 0; i < ichi.length; i++)
	{
		if(i == ichi.length-1)
		{
			ichi[i] = new OddballParticle();
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
		fill(0,0,0,12);
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

		mySpeed = Math.random()*4;
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
			if(dist( (float)myX,(float)myY, 300,300) <= mySpeed/2)
			{
				orientation = !orientation;
				// swirl = !swirl;
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
		ellipse((float)myX,(float)myY,5,5);
	}
}

class OddballParticle implements Particle
{
	double myX, myY, mySpeed, myAngle;
	double oldX, oldY;
	int myColor;

	OddballParticle()
	{
		myColor = color(255,255,255);
		myX = width/2;
		myY = height/2;
		mySpeed = (Math.random()*3)+(Math.random()*4);
		myAngle = Math.random()*2*Math.PI;
	}

	public void redo()
	{

	}

	public void move()
	{
		oldX = myX;
		oldY = myY;

		myX += (2*(Math.cos(myAngle) * mySpeed)) - (Math.cos(myAngle) * mySpeed);
		myY += (2*(Math.sin(myAngle) * mySpeed)) - (Math.sin(myAngle) * mySpeed);

		if(frameCount%15 == 0)
		{
			myAngle = Math.random()*2*Math.PI;
		}

		if(myX > width || myX < 0 )
		{
			myAngle = Math.PI - myAngle;
		}
		if(myY > height || myY < 0)
		{
			myAngle = -1 * myAngle;
		}
	}

	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,10,10);

		// strokeWeight(10);
		// stroke(myColor);
		// line((float)oldX,(float)oldY,(float)myX,(float)myY);
	}
}


