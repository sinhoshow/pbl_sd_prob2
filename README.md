
# Problema 02 - Interfaces de E/S

Projeto de Sensor Digital em FPGA utilizando Comunicação Serial.

O sistema utiliza a porta de comunicação serial (UART) de uma RaspberryPi para se comunicar com uma FPGA que é responsável por coletar dados de sensores conectados à própria.

O código responsável pela interação da Raspberry com a FPGA foi escrito em C.

O projeto da FPGA foi feito utilizando Verilog para descrever o circuito responsável pela leitura das requisições vindas da raspberry, solicitação dos dados aos sensores e resposta desses dados para a raspberry. Para carregar o circuito para a FPGA foi utilizado o Quartus v20.1.


## Recursos Utilizados
- Kit de desenvolvimento Mercúrio IV
- FPGA Cyclone IV
- Raspberry Pi Zero (ARMv6 BCM2835, SO RASPBIAN)
- Sensor DHT11
- Protoboard
- Fios

## Diretórios do projeto

#### fpga

- DHT11.v <br>
Este arquivo é referente ao sensor de umidade e temperatura DHT11, com todas as sunas funcionalidades como entrada e saída e sua máquina de estado

![transferenciadedados](https://user-images.githubusercontent.com/8845392/169427680-3a03d232-5cbf-4e7f-8bd8-7b05f11c88ad.jpeg)

O FPGA (MCU como descrito na imagem) envia para o sensor um pulso negativo de 18ms seguido de um pulso positivo de 20µS a 40µS, logo após o sensor envia para o FPGA uma resposta, e a seguir envia os bits de dados obtidos nas medições.

O sensor DHT11 envia 40 bits (5 bytes) mais os bits de inicialização. Os dados são transmitidos na seguinte ordem: – Parte Inteira de Umidade Relativa —> Parte Decimal da Umidade Relativa —> Parte Inteira da temperatura —> Parte Decimal da temperatura- -> Ch

- SDC1.sdc <br>
Este arquivo é referente a configuração do clock utilizado na FPGA.
- TRIS.v <br>
Este arquivo é referente ao módulo TRIS que permite que a pinagem tenha 3 funcionalidades. Faz com que o pino de dados do DHT11 funcione tanto para transmissão e solicitações de dados.
- BaudRateGenerator.v <br>
Este arquivo é referente ao gerador de Baud Rate responsável pelo número de vezes que um sinal em um canal de comunicação muda seu estado, ou varia.
- Top_Proj.v <br>
Arquivo principal do todo projeto, responsável pela integração entre o sensor e a UART da FPGA
- Uart8.v <br>
Arquivo que faz a junção da recepção e transmissão de dados da FPGA, incluindo baud rate.
- Uart8Transmitter.v <br>
Arquivo referente a transmissão de dados da uart da FPGA com 8 bits seriais, um bit de inicio e um bit de parada.
- UartStates.vh <br>
Arquivo com estados das maquinas de estados da transmissão e recepção de dados.
- clockDiv.v <br>

#### codigo_c

- main.c <br>
Este arquivo interage com o usuário e é responsável por fazer as solicitações do usuário para os sensores de umidade e temperatura 

#### imgs <br>
Pasta com imagens utilizadas no README.md.


## Diagramas de arquitetura e fluxo
- arquitetura

![arquitetura](imgs/arquitetura.png)

- fluxo

![fluxo](imgs/fluxo.png)


## Transferência de dados no circuito


## Instalação

Clonar repositório

```bash
  git clone https://github.com/sinhoshow/pbl_sd_prob2.git
```
O diretório "codigo_c" precisa estar na raspberry pi, para que possa ser feita a compilação e execução do arquivo main.c

Já o diretório "fpga" possui os arquivos em verilog que precisarão ser lançados na FPGA.

{demonstrar como lançar os arquivos .V para fpga}

Após os arquivos serem lançados na fpga, rodar o comando make all no diretório "codigo_c" na raspberry.

```bash
  make all
```
