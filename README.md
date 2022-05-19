# pbl_sd_prob2


Entradas:
- Solicitação de dado

Sensores:
- Temperatura e Umidade

Eletronicos:
- Raspibery Pi0
- FPGA

Objetivo:
A Raspibery faz uma solicitação (em linguagem C)  para FPGA ,da qual a mesma se comunica com o sensor, mandando assim um sinal ao sensor.
Esse sinal é retornado para a Uart da FPGA com os dados do qual em seguida é enviado e exibido na tela do Raspiberry através da interface da Raspiberry.


Essa aplicação permite gerar uma comunicação entre a UART e Raspibery e enviar os dados da temperatura e umidade.

Testagem: 
