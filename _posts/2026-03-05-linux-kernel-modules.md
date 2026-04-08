---
title: "Writing Linux Kernel Modules from Scratch"
date: 2026-03-05 09:00:00 +0800
categories: [Linux, Kernel]
tags: [linux, kernel, modules, c, drivers, lkm, character-device]
description: >-
  A practical guide to writing Linux Kernel Modules (LKMs) — covering the build system,
  module lifecycle, character device drivers, and interrupt handling,
  with a worked example of a GPIO character driver on a Raspberry Pi.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

Linux kernel module development sits at the intersection of systems programming and hardware
control. For embedded systems work — especially bringing up custom FPGA IP cores under
Linux on platforms like the Zynq — understanding how to write a clean kernel module is
an essential skill. This post documents the fundamentals without assuming prior kernel
development experience.

## Planned Content

### 1. Kernel Space vs. User Space
- Virtual memory separation and why it matters
- System call interface: the boundary crossing
- Why drivers live in kernel space (direct hardware access, interrupt context)
- When *not* to write a kernel module: UIO, VFIO, `sysfs` alternatives

### 2. The Linux Kernel Build System (Kbuild)
- Out-of-tree module `Makefile` structure
- `KERNELDIR`, `PWD`, and cross-compilation for ARM
- `MODULE_LICENSE`, `MODULE_AUTHOR`, `MODULE_DESCRIPTION`

### 3. Module Lifecycle
```c
module_init(my_driver_init);
module_exit(my_driver_exit);
```
- `insmod` / `rmmod` / `modprobe`
- `printk` and log levels: `KERN_INFO`, `KERN_ERR`, etc.
- Kernel symbol table: `EXPORT_SYMBOL`

### 4. Character Device Driver
- `struct file_operations`: `open`, `read`, `write`, `release`
- Allocating a major number dynamically with `alloc_chrdev_region`
- `cdev_init` and `cdev_add`
- Creating a device node automatically with `class_create` / `device_create`
- `copy_to_user` / `copy_from_user`: the safe crossing

### 5. Interrupt Handling
- Requesting an IRQ: `request_irq`
- Top half vs. bottom half: hardirq context limitations
- Tasklets and work queues for deferred processing
- Shared interrupts

### 6. Worked Example: GPIO Character Driver
- Reading a push-button state via interrupt
- Exposing events to userspace via `read()` blocking with `wait_event_interruptible`
- Testing with a simple Python userspace client

### 7. Debugging Kernel Code
- `dmesg` and `journalctl -k`
- `ftrace` for function tracing
- KGDB for source-level debugging (brief)
- Common pitfalls: sleeping in interrupt context, reference counting errors

## Platform

- Raspberry Pi 4 with Raspberry Pi OS (64-bit)
- Cross-compilation from x86_64 Linux host

---

*See also: FPGA AXI DMA on Zynq (coming soon) for a production kernel driver example.*
