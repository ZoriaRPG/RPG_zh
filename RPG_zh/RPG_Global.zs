//RPG.zh Global Active Template

global script RPG_Active{
	void run(){
		ffc globF[214747]; //Holds ffc pointers.
		npc globN[214747] //NPC pointers.
		item globI[214747]; //Item pointers
		itemdata globID[214747]; //Itemdata.
		int gRAM[214747]; //Strings and other globalRAM that we want to flush each load. 
		lweapon globLW[214747]; //LWeapons
		eweapon globEW[214747]; //EWeapons
		
		
		//Inits
		Assign_gRAM(gRAM);
		init_main();
		
		
		while( main() ){
			//Using a main() loop instead of an infinite loop, allows us to suspend it. 
			//We can possibly use calls to set_main() to have concurrent loops of different types.
			
			//Pre-WD functions
			if ( main() ) Waitdraw();
			
			//Post-WD functions
			if ( main() ) Waitframe();
			break;
		}
		
		//Cleanup if main() loop is terminated. 
	}
	
	void set_gRAM(int arr){
		
	
	void init_main(){
		int arr = GameDynamics[gRAM];
		arr[MAIN] = 1;
	}
	
	int main(){
		int arr = GameDynamics[gRAM];;
		return arr[MAIN];
	}
	
	void set_main(bool setting){
		int arr = GameDynamics[gRAM];
		if ( setting ) arr[MAIN] = 1;
		else arr[MAIN] = 0;
	}
	
	void stop(int stop){
		int arr = GameDynamics[gRAM];
		if ( stop ) arr[STOP] = 1;
		else arr[STOP] = 0;
	}
	
	//Stops a loop from running.
	void stop(int stop, int loop){
		int arr = GameDynamics[gRAM];
		if ( stop ) arr[loop] = 1;
		else arr[loop] = 0;
	}
	
	//Stops a loop from running.
	int running(int loop){
		int arr = GameDynamics[gRAM];
		return arr[loop];
	}
	
	//Stops a loop from running.
	void resume(int loop){
		int arr = GameDynamics[gRAM];
		arr[loop] = 1;
	}
	
	//Stops a loop from running.
	void runL(int loop){
		int arr = GameDynamics[gRAM];
		arr[loop] = 1;
	}
	
	//Stops a loop from running.
	void stop(int loop){
		int arr = GameDynamics[gRAM];
		arr[loop] = 0;
	}
	
	//Stops a loop from running.
	bool stoped(int loop){
		int arr = GameDynamics[gRAM];
		return arr[loop] == 0;
	}
	
	//Stops a loop from running.
	bool running(int loop){
		int arr = GameDynamics[gRAM];
		return arr[loop] != 0;
	}
	
	int stop(){
		int arr = GameDynamics[gRAM];
		return arr[STOP];
	}
	
	void do_waitframe(){}
	void do_waitdraw(){}
}

void DoWaitframe(){}
	
void DoWaitdraw(){}
	
	
}

const int MAIN = 214746;
		



		