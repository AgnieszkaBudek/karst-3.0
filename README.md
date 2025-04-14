
 # Pore-Network Model of Reactive Transport in Porous Media

 ## DESCRIPTION

This project is dedicated to simulating porous materials subjected to dissolution amd precipitation processes. The porous material is modeled as a network of tubes (pore throats) and is represented by the Network class. A pressure drop applied at the network edges results in fluid flow (water with dissolved reactants) through the system. Pore sizes can change due to chemical reactions with the reagents present in the fluid. The main reaction considered here is dissolution. In addition, a second type of reaction—precipitation—can also be tracked. The pore size can change in two ways: it can either grow due to dissolution or shrink due to precipitation.

 ### REPRESENTATION OF POROUS MATERIAL

 The porous material is modeled here as a network of interconnected tubes called pores. Pores are represented by the Pore class. Each pore spans between two nodes of the network, which are represented by the Node class. In addition to pores and nodes, the simulation can also track pieces of material subjected to dissolution—so-called grains—represented by the Grain class.


 ### EVOLUTION OF THE SYSTEM

The main purpose of this project is to simulate the dynamics of the system. The Network::evolution function performs $T$ time steps, each consisting of:

- calculating the pressure field in the nodes

- calculating the flow field in the pores

- calculating the concentration field in the nodes and pores

- updating the shape of pores and grains

- (optionally) changing the network topology if some grains have vanished due to dissolution

The simulation ends either after $T$ time steps (mainly in debugging mode) or when another condition related to the network properties is fulfilled. Typically, we use a breakthrough condition—the simulation stops when the dissolution pattern (a structure consisting of broad, dissolved pores) reaches the outlet of the system.


## Other remarks:

1. Branches:

- master: two reactions without transversal diffusion

- pure_diffusion: includes transversal diffusion; works only for the first reaction (dissolution), has to be tested

- fracture: models both dissolution and precipitation along a fracture 




## How to cite

[1] **Budek, A., & Szymczak, P.** (2012). *Network models of dissolution of porous media*. _Physical Review E_, **86**, 056318.  
 [DOI: 10.1103/PhysRevE.86.056318](https://doi.org/10.1103/PhysRevE.86.056318)
