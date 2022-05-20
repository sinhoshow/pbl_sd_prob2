
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

## Diagramas de arquitetura e fluxo
- arquitetura

![arquitetura](imgs/arquitetura.png)

- fluxo

![fluxo](imgs/fluxo.png)

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