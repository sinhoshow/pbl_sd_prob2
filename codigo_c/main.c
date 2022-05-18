#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <wiringPi.h>
#include <wiringSerial.h>

int main ()
{
  int option;
  int input_error = 0;
  int running = 1;
  int fd ;
  void enviaTemperatura(int fd);
  void enviaUmidade(int fd);

  //Inicializando UART;
  if ((fd = serialOpen ("/dev/ttyAMA0", 115200)) < 0)
  {
	fprintf (stderr, "Unable to open serial device: %s\n", strerror (errno)) ;
	return 1 ;
  }

  if (wiringPiSetup () == -1)
  {
	fprintf (stdout, "Unable to start wiringPi: %s\n", strerror (errno)) ;
	return 1 ;
  }
 
  //Fluxo de entrada de dados;
  while(running == 1){
	do{
  	if (input_error == 1){
      	printf("Selecione uma opção válida!\n");
  	}
 	 
 	 
  	printf("Selecione o dado desejado: \n");
  	printf("1 - Temperatura\n");
  	printf("2 - Umidade\n");
  	printf("3 - Encerrar\n"); 	 
  	scanf("%d", &option);
 	 
  	if (option == 1 || option == 2 || option == 3){
    	input_error = 0;
  	}else{
    	input_error = 1;
  	}
 	 
  	system("clear");    
	}while(input_error == 1);
    
	switch(option){
    	case 1:
      	printf("Ecolheu Temperatura\n");
      	enviaTemperatura(fd);
      	break;
    	case 2:
      	printf("Ecolheu Umidade\n");
      	enviaUmidade(fd);
      	break;
    	case 3:
      	running = 0;
    	default:
      	printf("Opção não mapeada\n");
	}
	printf("\n");
  }  
 
 
  return 0;
}

void enviaTemperatura(int fd){  
  printf("Solicitando temperatura...\n");
  serialPutchar(fd, '\x04');
 
  delay(3);
 
  while (serialDataAvail (fd)){    
	printf (" -> %3d", serialGetchar (fd)) ;
	fflush (stdout) ;
  }
}

void enviaUmidade(int fd){
  printf("Solicitando umidade...\n");
  serialPutchar(fd, '\x05');
 
  delay(3);
 
  while (serialDataAvail (fd)){    
	printf (" -> %3x", serialGetchar (fd)) ;
	fflush (stdout) ;
  }
}

