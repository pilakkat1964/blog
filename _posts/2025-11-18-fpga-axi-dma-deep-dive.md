---
title: "FPGA AXI DMA: Moving Data at Wire Speed on Zynq"
date: 2025-11-18 09:00:00 +0800
categories: [SDR, FPGA]
tags: [fpga, xilinx, zynq, axi, dma, vhdl, vivado]
description: >-
  A practical deep dive into Xilinx AXI DMA on the Zynq-7000 SoC —
  configuring scatter-gather mode, writing the Linux driver, and
  benchmarking sustained throughput for an SDR receive path.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

Moving data between the Programmable Logic (PL) and the Processing System (PS) on a Zynq
is conceptually simple — in practice, getting AXI DMA to sustain the throughput your SDR
application demands requires careful attention to buffer alignment, cache coherency, and
interrupt latency. This post documents the approach I use for a high-throughput SDR receive
path on the Zynq-7000.

## Planned Content

### 1. Zynq Architecture Recap
- PL ↔ PS interconnect: HP ports, ACP port, GP ports
- Why HP ports for DMA (cache-bypassing, 64-bit wide)
- AXI4 vs AXI4-Stream vs AXI4-Lite — when to use each

### 2. Vivado Block Design
- Instantiating the AXI DMA IP core
- Configuring scatter-gather vs. simple mode
- Connecting to a custom AXI4-Stream source (ADC sample FIFO)
- Clock domain crossing considerations

### 3. Linux Driver Side
- The `xilinx-dma` driver and its DMA engine API
- Allocating coherent DMA buffers (`dma_alloc_coherent`)
- Setting up scatter-gather descriptors
- Interrupt-driven completion vs. polling

### 4. Throughput Benchmark
- Test setup: PL generates a counter stream at 125 MHz (16-bit samples)
- Measuring achieved throughput with `perf` and custom timestamps
- Effect of buffer size on CPU overhead
- Observed bottleneck: PS DDR bandwidth, not AXI

### 5. Practical SDR Integration
- Ring buffer design for continuous capture
- Handing off samples to GNU Radio via shared memory
- Handling overflows gracefully

## Hardware Used

- Digilent Zybo Z7-20 development board
- Vivado 2023.2 / Vitis 2023.2
- PetaLinux 2023.2

---

*Part of the SDR series. See also: [SDR Fundamentals: I/Q Signals](/posts/sdr-fundamentals-iq-signals-and-baseband-processing/)*
