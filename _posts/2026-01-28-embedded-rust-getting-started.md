---
title: "Getting Started with Embedded Rust on ARM Cortex-M"
date: 2026-01-28 09:00:00 +0800
categories: [Embedded Systems, Rust]
tags: [rust, embedded, arm, cortex-m, rtos, no-std, hal]
description: >-
  A hands-on introduction to writing bare-metal firmware in Rust for ARM Cortex-M
  microcontrollers — toolchain setup, the no_std environment, memory-mapped
  peripheral access via PAC/HAL, and a working GPIO + UART example.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

After 30 years of writing embedded firmware in C and C++, switching to Rust for
microcontroller work felt equal parts exciting and frustrating. The ownership model
catches an entire class of bugs at compile time that used to find their way into
production firmware. The toolchain, once set up, is surprisingly ergonomic. This
post documents the path from zero to a working Cortex-M project.

## Planned Content

### 1. Why Rust for Embedded?
- Memory safety without a garbage collector
- Zero-cost abstractions: HAL APIs that compile away
- `unsafe` as a surgical tool, not a blanket permission
- Comparison with C/C++: what you gain, what you give up

### 2. Toolchain Setup
```bash
rustup target add thumbv7em-none-eabihf   # Cortex-M4F / M7
cargo install probe-rs-tools               # flash + debug via SWD
```
- `flip-link`: stack overflow detection at zero cost
- OpenOCD vs. probe-rs: when to use each

### 3. The `no_std` Environment
- What `std` provides and why it's absent on bare metal
- `core` and `alloc` crates
- Panic handlers: `panic-halt` vs. `panic-semihosting`
- Global allocators: when (and whether) to use heap on MCU

### 4. Peripheral Access: PAC → HAL → Board Support
- Peripheral Access Crates (PAC): machine-generated from SVD files
- Hardware Abstraction Layer (HAL): `stm32f4xx-hal` walkthrough
- Board Support Packages (BSP): opinionated convenience layer

### 5. Worked Example: UART Echo on STM32F4
- Project structure with `cargo generate`
- Configuring clocks with the RCC peripheral
- Interrupt-driven UART receive using RTIC
- Reading from flash using `defmt` + RTT for debug output

### 6. Next Steps: Embassy Async Runtime
- Why `async/await` makes sense on microcontrollers
- Embassy executor: cooperative multitasking without an RTOS
- Preview of the ESP32 post (Embassy + Wi-Fi)

## Hardware Used

- STM32F4-Discovery or NUCLEO-F446RE
- ST-Link V2 debugger (or any probe-rs compatible probe)

---

*See also: [Rust on ESP32: From Blinky to Async Wi-Fi](/posts/rust-on-esp32-from-blinky-to-async-wi-fi/)*
