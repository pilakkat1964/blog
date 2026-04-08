---
title: "IIoT Edge Connectivity: Comparing Private LTE, 5G and Wi-Fi 6"
date: 2026-01-10 09:00:00 +0800
categories: [Industrial Automation, Connectivity]
tags: [iiot, lte, 5g, wifi6, edge, cbrs, latency, reliability]
description: >-
  A structured comparison of the three main wireless technologies competing
  for the industrial edge — Private LTE, 5G NR SA, and Wi-Fi 6/6E —
  across latency, reliability, cost, and integration complexity.
---

> **🚧 Work in Progress** — This post is a placeholder. Full content coming soon.
{: .prompt-warning }

When specifying the wireless infrastructure for an IIoT deployment, you will quickly find
yourself pulled in three directions: the IT team wants Wi-Fi 6, the OT integrator is pushing
Private LTE, and the vendor demo just showed 5G. This post provides a structured framework
for making the right choice — and it is rarely a single technology.

## Planned Content

### 1. The IIoT Connectivity Requirements Matrix
- Traffic types: telemetry, control, video inspection, AGV navigation
- Latency: best-effort vs. bounded vs. hard real-time
- Reliability: 99.9% vs. 99.999% ("five nines" for safety systems)
- Mobility: fixed sensors vs. moving machinery vs. handheld devices

### 2. Wi-Fi 6 / 6E (IEEE 802.11ax)
- What's new: OFDMA, MU-MIMO, TWT, BSS colouring
- Why it still struggles in dense RF environments
- Best fit: high-bandwidth, non-critical, IT-domain traffic
- Integration with industrial protocols: PROFINET over Wi-Fi concerns

### 3. Private LTE (CBRS / Band 48)
- Citizens Broadband Radio Service (CBRS) and the SAS model
- Advantages: proven reliability, mature ecosystem, SIM-based security
- Latency floor: ~20–30 ms round-trip (EPC + backhaul)
- Best fit: wide-area coverage, AGVs, brownfield deployments

### 4. 5G NR Standalone (SA)
- Why SA matters: true network slicing, URLLC, reduced latency vs. NSA
- Spectrum: 3.5 GHz for coverage, mmWave for high-density indoor
- 5G latency reality: ~5–10 ms (user plane optimised) vs. marketing claims
- Best fit: greenfield smart factories, TSN integration, mixed critical/non-critical

### 5. Decision Framework
- A scored comparison matrix across 12 criteria
- Use case archetypes: which technology wins in each scenario
- Hybrid architectures: Wi-Fi 6 for telemetry + 5G NR for control

### 6. Cost Considerations
- CAPEX: spectrum licensing, RAN infrastructure, UE modems
- OPEX: SIM management, MNO-hosted vs. on-premise core

---

*Part of the Industrial Automation series.*
