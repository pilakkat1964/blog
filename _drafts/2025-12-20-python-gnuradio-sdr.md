---
title: "Building an SDR Receiver Pipeline with GNU Radio and Python"
date: 2025-12-20 09:00:00 +0800
categories: [Programming, Python]
tags: [python, gnuradio, sdr, dsp, raspberry-pi, rtl-sdr, flowgraph]
description: >-
  A step-by-step guide to building a complete SDR receive pipeline in GNU Radio —
  from RTL-SDR source to demodulated audio — with Python scripting to automate
  frequency scanning and signal logging.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

GNU Radio is the de-facto standard toolkit for SDR signal processing. It bridges the gap
between the hardware (your RTL-SDR, HackRF, or USRP) and the signal processing algorithms
you want to apply — all wired together in a flowgraph that can be built graphically or
driven from Python. This post walks through building a practical FM receiver pipeline,
then extends it with Python automation for wideband scanning.

## Planned Content

### 1. GNU Radio Architecture
- The flowgraph model: sources, sinks, and signal processing blocks
- Scheduler: how GNU Radio manages threading and buffer flow
- GNU Radio Companion (GRC) vs. pure Python (`gr.top_block`)
- When to write a custom OOT (out-of-tree) block

### 2. Installation and Hardware Setup
```bash
# Ubuntu/Debian
sudo apt install gnuradio gr-osmosdr rtl-sdr
# Check RTL-SDR is detected
rtl_test -t
```
- Blacklisting the `dvb_usb_rtl28xxu` kernel module
- Verifying gain, sample rate and frequency offset

### 3. FM Broadcast Receiver Flowgraph
- RTL-SDR Source → Low Pass Filter → WBFM Receive → Audio Sink
- Tuning: frequency, gain, quadrature rate
- Understanding the rational resampler: 2.4 MSPS → 48 kHz

### 4. Moving to Python: Scripting the Flowgraph
```python
import osmosdr
from gnuradio import gr, analog, audio, filter

class FMReceiver(gr.top_block):
    def __init__(self, freq=98.7e6):
        gr.top_block.__init__(self)
        # ... block construction
```
- Starting and stopping the flowgraph programmatically
- Connecting a `probe_signal_f` to read signal strength in Python
- Logging to a SQLite database

### 5. Wideband Scanner
- Sweeping across a frequency range
- Detecting occupied channels by power threshold
- Logging channel activity with timestamps

### 6. Writing a Simple OOT Block
- `gr_modtool newmod` scaffolding
- Implementing a simple power detector block in Python
- Unit testing with `gr_unittest`

### 7. Running on a Raspberry Pi 5
- Performance: achievable sample rates on Pi 5 vs. x86
- Using `gr-soapy` for hardware abstraction
- Remote streaming: `gr-zeromq` for offloading processing to a laptop

## Hardware Used

- RTL-SDR v4 (or HackRF One for transmit capability)
- Raspberry Pi 5 (8 GB) with Raspberry Pi OS

---

*See also: [SDR Fundamentals: I/Q Signals](/posts/sdr-fundamentals-iq-signals-and-baseband-processing/)*
