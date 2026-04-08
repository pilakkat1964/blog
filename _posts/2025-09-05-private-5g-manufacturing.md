---
title: "Private 5G Networks for Smart Manufacturing"
date: 2025-09-05 09:00:00 +0800
categories: [5G & Wireless, Private Networks]
tags: [5g, private-5g, iiot, manufacturing, nr, cbrs]
description: >-
  An architect's perspective on deploying private 5G networks in manufacturing environments —
  spectrum options, RAN selection, core network sizing, and lessons from the 5GAMSUS program.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

Between 2018 and 2023 I served as the System Architect for A\*STAR's
*5G for Advanced Manufacturing and Smart Urban Systems* (5GAMSUS) inter-institute program.
This post distils the architectural lessons from that program into a practical guide for
engineers considering a private 5G deployment for industrial use.

## Planned Content

### 1. Why Private 5G for Manufacturing?
- Comparing Wi-Fi 6, Private LTE (CBRS/sXGP), and 5G NR SA
- Latency and reliability requirements in manufacturing (IEC 62443 context)
- The determinism gap: where 5G alone isn't enough (and TSN fills it)

### 2. Spectrum Options by Region
- 3.5 GHz CBRS (USA) / 3.5–3.8 GHz licensed bands
- Singapore IMDA spectrum framework for private networks
- mmWave for indoor high-density scenarios

### 3. RAN Architecture Choices
- Monolithic gNB vs. O-RAN disaggregated (CU/DU/RU split)
- Indoor small cells: choosing between vendors
- Antenna placement for factory floor coverage

### 4. 5G Core (5GC) for Private Networks
- Standalone (SA) vs Non-Standalone (NSA) — why SA matters for private
- Open-source 5GC options: Open5GS, free5GC
- Network slicing for mixed traffic (sensor telemetry vs. video inspection)

### 5. Integration with OT Systems
- OPC-UA over 5G
- Time-sensitive traffic: using 5G QoS flows to carry TSN streams
- Security segmentation between IT and OT domains

### 6. Lessons from 5GAMSUS
- What worked: dynamic spectrum sharing, slice-based QoS
- What didn't: handover latency at factory cell boundaries
- Recommendations for greenfield vs. brownfield deployments

---

*See also: [TSN over 5G for Industrial Automation](/posts/time-sensitive-networking-tsn-over-5g-for-industrial-automation/),
[IIoT Edge Connectivity Comparison](/posts/iiot-edge-connectivity-comparing-private-lte-5g-and-wi-fi-6/)*
