package com.revature.models;

public class Cat extends Animal{
	
	private int numberOfLives;
	private String breed;
	private boolean hasFur;
	
	public Cat() {
		this.numberOfLives = 9;
		this.breed = "Domestic Shorthair";
		this.hasFur = true;
	}
	
	public Cat(int numberOfLives, String breed, boolean hasFur) {
		super();
		this.numberOfLives = numberOfLives;
		this.breed = breed;
		this.hasFur = hasFur;
		
	
	}

	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + (hasFur ? 1231 : 1237);
		result = prime * result + numberOfLives;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cat other = (Cat) obj;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (hasFur != other.hasFur)
			return false;
		if (numberOfLives != other.numberOfLives)
			return false;
		return true;
	}

	
	
	
	
}