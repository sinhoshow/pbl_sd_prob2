# pbl_sd_prob2


Entradas:
- Solicitação de dado

Sensores:
- Temperatura e Umidade

Recursos utilizados:
O código  C foi desenvolvido para a Raspberry pi Zero,
portanto é necessário ter a placa para execução do código. Na versão ARMv6 BCM2835, sistema operacional RASPBIAN.
 
O código Verilog foi desenvolvido para FPGA Cyclone IV do kit de desenvolvimento mercurio IV device … , no programa Quartus versão 20.1.


Objetivo:
A Raspibery faz uma solicitação (em linguagem C)  para FPGA ,da qual a mesma se comunica com o sensor, mandando assim um sinal ao sensor.
Esse sinal é retornado para a Uart da FPGA com os dados do qual em seguida é enviado e exibido na tela do Raspiberry através da interface da Raspiberry.


Essa aplicação permite gerar uma comunicação entre a UART e Raspibery e enviar os dados da temperatura e umidade.

Testagem: 


Sensor de Umidade e temperatura  DHT11
![sensor-de-umidade-e-temperatura-dht11](https://user-images.githubusercontent.com/8845392/169423907-19a8ab51-d1b9-4970-ace5-84bf40c9abdc.jpg)
