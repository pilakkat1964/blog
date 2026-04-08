---
title: "Time-Sensitive Networking (TSN) over 5G for Industrial Automation"
date: 2025-12-03 09:00:00 +0800
categories: [Industrial Automation, TSN]
tags: [tsn, 5g, deterministic, iiot, rami40, ieee802-1q, latency]
description: >-
  How TSN and 5G complement each other to deliver deterministic wireless communication
  for industrial automation — architecture, standards, and real deployment considerations.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

5G promises ultra-reliable low-latency communication (URLLC). TSN (IEEE 802.1Q and related
standards) delivers deterministic Ethernet for factory automation. Together they should
enable fully wireless industrial control — but making them work together in practice is
considerably more involved than either standard alone suggests.

This post documents the architecture and lessons from leading TSN-over-5G industry engagement
projects at A\*STAR I2R, targeting smart factory automation applications.

## Planned Content

### 1. Why Determinism Matters in Manufacturing
- Hard real-time requirements: PLC cycle times, motion control, safety systems
- Jitter vs. latency: the industrial control system perspective
- Where 5G URLLC falls short on its own

### 2. TSN Standards Primer
- IEEE 802.1Qbv (Time-Aware Shaper) — the gating mechanism
- IEEE 802.1CB (Frame Replication and Elimination for Reliability)
- IEEE 802.1AS (Precision Time Protocol for TSN — gPTP)
- 3GPP Rel-16 5G TSN bridge architecture

### 3. The 3GPP TSN Bridge Architecture
- How the 5G system acts as a TSN bridge (UE-side and NW-side TSN translators)
- DS-TT and NW-TT: the translation functions
- Time synchronisation propagation over the 5G air interface
- Residual latency budget: radio scheduler + transport + backhaul

### 4. End-to-End Deployment Architecture
- PLC → TSN switch → 5G UE → gNB → UPF → TSN switch → actuator
- Mapping TSN traffic classes to 5G QoS flows
- Handling clock domain boundaries (gPTP ↔ 5G internal timing)

### 5. Measurement Results
- Achieved end-to-end latency on a lab testbed (5G SA + Open5GS + custom TSN bridge)
- Jitter characterisation under load
- Failure recovery with 802.1CB frame replication

### 6. RAMI 4.0 and IIC IIRA Alignment
- Where TSN-over-5G sits in the RAMI 4.0 architecture layers
- Mapping to IIC Industrial Internet Reference Architecture connectivity tiers

---

*See also: [Private 5G Networks for Smart Manufacturing](/posts/private-5g-networks-for-smart-manufacturing/)*
