/**
 * Driver.java
 * Moded By Daniel Noyes
 *
 * Figure 4.12
 * @author Gagne, Galvin, Silberschatz
 * Operating System Concepts  - Ninth Edition
 * Copyright John Wiley & Sons - 2013
 */


class Sum
{
	private int sum;

	public int get() {
		return sum;
	}

	public void set(int sum) {
		this.sum = sum;
	}
}

class Summation implements Runnable
{
	private int upper;
	private Sum sumValue;

	public Summation(int upper, Sum sumValue) {
		if (upper < 0)
			throw new IllegalArgumentException();

		this.upper = upper;
		this.sumValue = sumValue;
	}

	public void run() {
		int sum = 0;

		for (int i = 0; i <= upper; i++)
			sum += i;

		sumValue.set(sum);
	}
}

class Factorial implements Runnable
{
	private int upper;
	private Sum FacValue;

	public Factorial(int upper, Sum FacValue) {
		if (upper < 0)
			throw new IllegalArgumentException();

		this.upper = upper;
		this.FacValue = FacValue;
	}

	public void run() {
		int Fac = 1;

		for (int i = 1; i <= upper; i++)
			Fac *= i;

		FacValue.set(Fac);
	}
}

public class Driver
{
	public static void main(String[] args) {
		if (args.length != 1) {
			System.err.println("Usage Driver <integer>");
			System.exit(0);
		}
		//Summation Routine
		Sum sumObject = new Sum();
		int upper = Integer.parseInt(args[0]);
		
		Thread worker = new Thread(new Summation(upper, sumObject));
		worker.start();
		try {
			worker.join();
		} catch (InterruptedException ie) { }
		System.out.println("The sum of " + upper + " is " + sumObject.get());

		//Factorial Routine
		Sum facObject = new Sum();
		int upper2 = Integer.parseInt(args[0]);
		
		Thread worker2 = new Thread(new Factorial(upper, facObject));
		worker2.start();
		try {
			worker2.join();
		} catch (InterruptedException ie) { }
		System.out.println("The Factorial of " + upper2 + " is " + facObject.get());


	}
}
