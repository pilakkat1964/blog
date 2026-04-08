---
title: "3D Printing Custom Electronics Enclosures — A Practical Guide"
date: 2025-08-20 09:00:00 +0800
categories: [3D Printing, Electronics]
tags: [3d-printing, enclosures, pcb, cad, fusion360, fdm, petg]
description: >-
  A practical workflow for designing and printing custom enclosures for electronics
  projects — from PCB measurements to finished print, with tips on tolerances,
  material selection, and finishing for a professional result.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

Off-the-shelf enclosures rarely fit custom PCBs well. 3D printing has made it practical
to produce bespoke enclosures in an afternoon — but there is a craft to doing it well.
After going through many iterations on enclosures for SDR front-ends, FPGA breakout boards,
and RF test fixtures, this post documents the workflow that has worked best for me.

## Planned Content

### 1. When to Print vs. When to Buy
- Cost crossover: when a printed enclosure beats a standard ABS box
- Limitations: RF shielding, thermal dissipation, IP ratings
- Good candidates: prototypes, low-volume production, oddly shaped boards

### 2. Measuring Your PCB
- Key dimensions: board outline, mounting holes, connector positions, component heights
- Calipers vs. PCB design file export (DXF/STEP)
- Importing PCB STEP files directly into CAD for perfect fit

### 3. CAD Workflow (Fusion 360 / FreeCAD)
- Parametric design: key dimensions as named variables
- Designing for print: wall thickness, snap-fit tolerances, bridging limits
- Ventilation slots for heat dissipation
- Panel cutouts for connectors, LEDs, and buttons
- Lid attachment: screws vs. snap-fit vs. press-fit

### 4. Material Selection
- PLA: easy to print, poor temperature resistance — avoid near power electronics
- PETG: the sweet spot for electronics enclosures — heat resistant, tough, low warp
- ABS / ASA: best for outdoor / high-temp but harder to print
- Print settings: layer height, infill %, wall count for rigidity

### 5. Tolerances for Electronics
- Clearance for PCB sliding into slots: +0.2 mm typical
- Press-fit standoffs: -0.1 to -0.2 mm interference
- M3 heat-set insert holes: printer-specific — always calibrate

### 6. Post-Processing for Professional Results
- Sanding: 120 → 240 → 400 grit for smooth surfaces
- Acetone vapour smoothing (ABS only — safety precautions)
- Spray primer + paint: adhesion promoter for PETG
- Applying adhesive labels with a Cricut or vinyl cutter

### 7. Example Project: SDR Receiver Front-End Box
- RTL-SDR v4 + LNA + bandpass filter in a single shielded enclosure
- RF connector cutouts with precise SMA positions from PCB STEP file
- Printed SMA panel with brass inserts

## Equipment Used

- Bambu Lab P1S (AMS for multi-material)
- Prusa MK4 for PETG/ABS
- Fusion 360 for CAD

---

*Related: DIY projects tag for more hands-on build posts.*
