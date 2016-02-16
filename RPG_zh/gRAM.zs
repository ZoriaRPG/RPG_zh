//Constants for Array indices...

//Global Active Local RAM
const int FAKELINKX = 0;
const int FAKELINKY = 1; 
const int FAKELINKZ = 2;
const int FX = 3;
const int FY = 4;
const int FSPEED = 5;
const int SWORDPOINTS = 6;

//Global RAM
//Global RAM
const int GRAM_PTR = 0; //Array index in GLobalArr[] that will store the pointer for gRAM[]

float GlobalArr[214747]; //Global RAM Array. This is the largest size available, and my tests show this not to matter, except in iteration loops.





global script active{
	void run(){
		float gRAM[2048]; //Global Active Local RAM
		GlobalArr[GRAM_PTR] = gRAM; //Store the pointer for the local array, so that we may always access it.
	}
	void setG(int index, int val){  //You can't do this without arrays...
		int arr = GlobalArr[GRAM_PTR];
		arr[index] = val;
	}
	void modG(int index, int val){ 
		int arr = GlobalArr[GRAM_PTR];
		arr[index] += val;
	}
	float getG(int index) { 
		int arr = GlobalArr[GRAM_PTR];
		return arr[index];
	}
	int isG(int index) {
		int arr = GlobalArr[GRAM_PTR];
		return arr[index];
	}
	void isG(int index, bool setting) { 
		int arr = GlobalArr[GRAM_PTR];
		if ( setting ) arr[index] = 1;
		else arr[index] = 0;
	}
	
}

ffc script ModGRAM{
	void run(){
		if ( active.isG(FX) > 20 ) {
			active.setG(FAKELINKX,20); //You can call functions that are local to the global active script
			active.setG(FAKELINKY,10); //to set a value local to it this way. You CANNOT do this WITHOUT ARRAYS.
		} //You can also read values stored in the global active script array this way. :)
	}         //This means that you can store temp values per session in a RAM buffer that you can read from anywhere. 
}

