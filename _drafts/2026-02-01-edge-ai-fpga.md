---
title: "Edge AI/ML Inference on FPGA with Vitis AI"
date: 2026-02-01 09:00:00 +0800
categories: [AI/ML, Edge Inference]
tags: [ai, ml, fpga, vitis-ai, xilinx, inference, dpu, quantisation]
description: >-
  How to deploy a trained neural network onto a Xilinx Zynq UltraScale+ FPGA
  using the Vitis AI toolchain — covering model quantisation, DPU configuration,
  and a worked object detection example running at 30 FPS on the edge.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

Cloud AI inference is convenient but expensive, power-hungry, and latency-limited by the
round trip to a data centre. For industrial applications — visual quality inspection,
anomaly detection on sensor data, real-time signal classification in SDR — inference needs
to happen at the edge. The Xilinx DPU (Deep Learning Processing Unit) on Zynq UltraScale+
devices offers a compelling mix of performance, power efficiency, and programmability.

## Planned Content

### 1. Why FPGA for Edge AI?
- GPU vs. ASIC vs. FPGA: the tradeoffs
- Power envelope: comparing NVIDIA Jetson, Google Coral, and Zynq MPSoC
- Reconfigurability: swapping the DPU architecture for different model types
- Use case fit: when FPGA wins (low latency, deterministic, SWaP-constrained)

### 2. The Vitis AI Toolchain
- Quantiser (XIR → xmodel): INT8 quantisation with calibration dataset
- Compiler: mapping quantised ops to DPU instruction set
- Runtime: loading and running xmodel on the DPU from Python/C++
- Supported frameworks: PyTorch, TensorFlow 2, Caffe

### 3. DPU Configuration on Zynq UltraScale+
- DPU IP core parameters: B-series architecture, CU count, RAM usage
- Vivado block design integration
- PetaLinux/Yocto layer for Vitis AI runtime libraries
- Choosing the right Zynq MPSoC (ZCU102 vs. KV260 for development)

### 4. Worked Example: YOLOv8n Visual Inspection
- Training a small YOLOv8n model on a PCB defect dataset
- Quantisation-aware training vs. post-training quantisation
- Compiling and deploying to KV260
- Measuring latency and throughput: fps, power draw (measured)

### 5. SDR Signal Classification Application
- Brief preview: using a CNN to classify modulation schemes from I/Q samples
- Why this is a natural fit for FPGA: sample stream → classifier → decision
- Performance comparison: DPU vs. ARM Cortex-A53 vs. x86

### 6. Quantisation Accuracy Loss — Mitigation Strategies
- Sensitive layer identification
- Mixed-precision quantisation
- Fine-tuning after quantisation

## Hardware Used

- AMD/Xilinx KV260 Vision AI Starter Kit
- Vitis AI 3.5
- YOLOv8 (Ultralytics)

---

*Related: [FPGA AXI DMA on Zynq](/posts/fpga-axi-dma-deep-dive/)*
