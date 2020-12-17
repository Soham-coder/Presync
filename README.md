# Presync

# Title
PreSyNC: Hardware realization of the Presynaptic Region of a Biologically Extensive Neuronal Circuitry

```diff
@@ Abstract—@@
Spiking Neural Networks (SNN) have gained relevance in recent times, due to their ability to mimic the biological nature to communicate and process sparse asynchronous binary signals in a massively parallel fashion. SNN based neuromorphic hardware exhibits highly desired favourable properties such as low power consumption, fast inference, and event-driven information processing. A recognized challenge of standard SNN neuron models is their limited capabilities in biological applications, such as applying neural networks to study network responses arising from variations pertaining to damage, external influence or disruptions in channel transfer dynamics.

This paper presents Pre-Synaptic Neuronal Circuit (PreSyNC), a high performance hardware realization of an input-specific presynaptic region of a generic neuron, without abstraction of primary intra-neuronal parameters. PreSyNC is configured to operate on three precision modes: IEEE 754 single precision, double precision and the recently developed universal number posit number system. The developed hardware design is compared to current standards of SNN neuron models as well as biological models in terms of flexibility, resource efficiency and damage modelling capability. Error margins as low as 0.9% were obtained and suggest the capability of our hardware in handling applications involving large scale neuron networks. These architectures are synthesized on 45 nm process
technology where they all operate at a minimum frequency of approximately 1GHz. The three precision modes are compared based on power, accuracy, and sensitivity handling and are expected to benefit implantation oriented applications such as neural prosthesis and Human-Computer Interaction (HMI). The posit-based implementation outperforms the rest of the operating modes in terms of RMS error, while having 26.3% less area and 25.2% less power consumption compared to double precision implementation. These new architectures can be expanded in the future with various post-synaptic inputs to open up a broader understanding of biological systems and other applications.

+ Index Terms—Neuromorphic computation, presynaptic region, neural networks, posit arithmetic
```

#Hardware

Hardware Modelling of Synaptic Accelerator by taking realtime most accurate parameters consisting of several polynomial approximations in Floating point IEEE-754 32 bit & 64 bit format and recently developed Posit<32,4> format and making a comparitive study of them in terms of accuracy,precision and sensitivity handling and hardware cost.The designs are pipelined to meet 1 Ghz frequency in 45nm ASIC with low area and cost.