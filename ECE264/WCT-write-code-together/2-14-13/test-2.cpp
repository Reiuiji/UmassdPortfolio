main() 
{
        // Some points.
        Point a(5.2, -4.8);
        Point b(3.0, 9.0);
        Point c(-3.38);
        Point d;

        // Some arith. on the points.
        d = b.sub(c);
        // Point variables are not references.
        Point fred[5];
        for(int m = 0; m < 5; m++) fred[m] = a;
        double w = 4.5;
        double x = -2.31;
        for(int m = 0; m < 5; m++) 
		{
                fred[m].move(w, x);
                w += 3.4;
                x -= 1.3;
        }
        for(int m = 0; m < 5; m++)
		{
                fred[m].displayMessage(); 
               
        }
}
