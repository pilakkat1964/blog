---
title: "SDR Fundamentals: I/Q Signals and Baseband Processing"
date: 2025-10-12 09:00:00 +0800
categories: [SDR, Fundamentals]
tags: [sdr, iq-signals, dsp, ofdm, baseband]
description: >-
  A ground-up explanation of I/Q (in-phase/quadrature) signals — the mathematical
  foundation of every Software-Defined Radio system — with worked examples in Python.
image:
  path: /assets/img/posts/sdr-iq-placeholder.png
  alt: I/Q signal constellation diagram
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

I/Q (in-phase and quadrature) representation is the lingua franca of every SDR system,
yet it trips up a surprising number of engineers encountering it for the first time. This
post builds the concept from the ground up — starting from Euler's formula and ending at
a working Python receiver that demodulates a BPSK signal from raw samples.

## Planned Content

### 1. Why Two Components?
- The complex baseband representation
- Euler's formula: $e^{j\omega t} = \cos(\omega t) + j\sin(\omega t)$
- Why real passband signals map to complex baseband

### 2. The I/Q Modulator in Hardware
- Quadrature mixer architecture
- LO phase and amplitude imbalance — practical consequences
- How an RTL-SDR dongle generates I and Q samples

### 3. Baseband Processing Pipeline
- Sampling and the Nyquist criterion revisited for complex signals
- Filtering: matched filter vs. root-raised cosine
- Symbol timing recovery

### 4. Python Worked Example
- Generating a BPSK signal with SciPy
- Adding AWGN noise
- Demodulating and plotting the constellation
- Measuring BER vs. Eb/N0

### 5. Bridging to OFDM
- Why OFDM is just many I/Q channels in parallel
- The role of the FFT in OFDM demodulation
- Preview: cyclic prefix and inter-symbol interference

## Prerequisites

Basic familiarity with complex numbers and the Fourier transform. No prior SDR experience needed.

## Code

All code will be available in the companion GitHub repository once the post is published.

---

*Related posts in this series: [FPGA AXI DMA on Zynq](/posts/fpga-axi-dma-deep-dive/),
[GNU Radio SDR Pipeline](/posts/building-an-sdr-receiver-pipeline-with-gnu-radio-and-python/)*
