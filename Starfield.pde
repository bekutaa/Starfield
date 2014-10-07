int frameCount = 0;

Particle [] ichi;

void setup()
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
void draw()
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
			myAngle -= 0.02;
		}
		else 
		{
			myAngle += 0.02;	
		}
	}

	public void show()
	{
		noStroke();
		fill(myColor);
		ellipse((float)myX,(float)myY,5,5);
	}
}

interface Particle
{
	public void move();
	public void show();
}

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
		if(Math.random() > 0.5)
		{
			myX += ( Math.cos(myAngle) * mySpeed);
		}
		else
		{
			myX -= ( Math.cos(myAngle) * mySpeed);
		}
		if(Math.random() > 0.5)
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
}


