`timescale 1ns / 1ps

module Top_Proj(
	GPIO_LED1,		//Sinalização START
	GPIO_LED2,		//Sinalização START
	PMOD2_P1,     //DHT
	PMOD2_P2,		//DHT ERROR
	PMOD2_P3,		//Debug
	CLK50MHZ		//Clock Principal
	);

	//Entradas
	input CLK50MHZ;
	
	//Saidas
	output PMOD2_P2, GPIO_LED1, GPIO_LED2, PMOD2_P3;      //Saida PMOD	
	inout PMOD2_P1;
	
	//Wires do Divisor
	wire CLK6M25HZ, CLK48k9HZ, CLK2_98HZ;
	
   //Wires para DHT11
	wire EN_DHT11, RST_DHT11, DHT_DATA, CRC_DHT, WAIT_DHT11, ERROR_DHT11;
	wire [0:7] HUM_INT, HUM_FLOAT, TEMP_INT, TEMP_FLOAT;
	reg EN_DHT11_REG, RST_DHT11_REG;
	
	//FSM Start
	reg EN_DHT11_REG_START, RST_DHT11_REG_START;
	
	//assign EN_DHT11 = EN_DHT11_REG;
	assign PMOD2_P2 = ERROR_DHT11;
	
	//Multiplexa a saida entre FSM Start e FSM Principal
	assign EN_DHT11 = STARTED ? EN_DHT11_REG : EN_DHT11_REG_START;	
   assign RST_DHT11 = STARTED ? RST_DHT11_REG : RST_DHT11_REG_START;			
		
	
	//assign PMOD2_P1 = DHT_DATA;
	

	//Multiplexador
	//mux2x1 mux1 (BUFF8MHZ, CLK6M25HZ, GPIO_DIP1, PMOD1_P1);

	//Divisor de clock
	clockDiv clkdv01 (CLK50MHZ, CLK6M25HZ, CLK48k9HZ, CLK2_98HZ);	
	

  DHT11 DHT11(
		 .CLK(CLK50MHZ),  //50 MHz
		 .EN(EN_DHT11),
		 .RST(RST_DHT11),
		 .DHT_DATA(PMOD2_P1),
		 .HUM_INT(HUM_INT),
		 .HUM_FLOAT(HUM_FLOAT),
		 .TEMP_INT(TEMP_INT),
		 .TEMP_FLOAT(TEMP_FLOAT),
		 .CRC(CRC_DHT),
		 .WAIT(WAIT_DHT11),
		 .error(ERROR_DHT11),
		 .DEBUG(PMOD2_P3)
		 );

	
	reg [1:0] FSMSTARTSTATE; //O tamanho do registrador deve garantir a quantidade de estados
	reg STARTED;
	reg LED;
	reg LED_START;
	
	//assign GPIO_LED1 = LED;
	assign GPIO_LED1 = STARTED ? LED : LED_START;
	
	// Estados da maquina de estados de inicialização
	parameter START0=0,START1=1, START2=2, START3=3;
	
	// Maquina de estados de inicialização
	
	always @(posedge CLK50MHZ)
	begin: FSMSTART	
	  begin
			case (FSMSTARTSTATE)
			
				START0:
				  begin
				   
					 STARTED <= 1'b0;
					 LED_START <=1;
					 EN_DHT11_REG_START <= 1'b1;
					 RST_DHT11_REG_START <= 1'b1;

					 FSMSTARTSTATE <= START1;
				   end
									
				START1:
				  begin
				  
				   LED_START <=0;
					EN_DHT11_REG_START <= 1'b0;
					RST_DHT11_REG_START <= 1'b0; 
					STARTED <= 1'b1;
					 
					FSMSTARTSTATE <= START2;
				   end

				START2:
				  begin											
						 FSMSTARTSTATE <= START2;
				   end					
					
				default: 
					begin
					  FSMSTARTSTATE <= START0;
					end				
			endcase
 	  end
	end	
	
	
	//contador para testes
	reg [7:0] TEMPERATURE;
	reg LED2;
	
	assign GPIO_LED2 = LED2;
	
	
	reg [3:0] STATE; //O tamanho do registrador deve garantir a quantidade de estados
	
	parameter SDHT1=1,SDHT2=2, SDHT3=3, WAIT1=14, WAIT2=15;
	
	
	always @(posedge CLK50MHZ)
	begin: FSM
	  if (STARTED == 1'b1)
	  begin
			case (STATE)				
			
				SDHT1:
				  begin				
		          LED2 <= 1'b1;		  
					 EN_DHT11_REG <= 1'b1;
					 RST_DHT11_REG <= 1'b1;	 
					 STATE <= SDHT2;
				   end
					
				 SDHT2:
				   begin
						LED2 <= 1'b0;
					  if (WAIT_DHT11 == 1'b1)
					  begin
							STATE <= SDHT3;
					  end else begin
						  RST_DHT11_REG <= 1'b0;
						  EN_DHT11_REG <= 1'b1;		
						end
				   end
					
				SDHT3:
					begin
					   LED2 <= 1'b1;
						if (WAIT_DHT11 == 1'b0)
						begin
						   TEMPERATURE <= TEMP_INT;
							EN_DHT11_REG <= 1'b0;
							STATE <= WAIT1;
						end 					
					end
			
				//Aguardar para proximo ciclo de aquisicao de dados	
				WAIT1:
					begin
						if (CLK2_98HZ == 1)						
						begin
							STATE <= WAIT2;
						end
					end
				WAIT2:
					begin
						if (CLK2_98HZ == 0)
						begin
							STATE <= SDHT1;
						end
					end
			endcase					
		end
	  end
	
endmodule


