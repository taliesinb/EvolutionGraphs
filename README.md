# Evolution graphs

This project summarizes some of the work done by Antonia Kaestner and Taliesin Beynon at the Wolfram Physics Summer School held virtually on July 2020. For more information, please see Antonia's post on the Wolfram Community titled [Graph Representation of Biological Evolution](https://community.wolfram.com/groups/-/m/t/2029538).

# Motivation

Generalizing biological evolution, including concepts like genetic drift and selection, into a graph representation will provide a new perspective on this well established field. A general model has the potential to be expanded with new ideas, integrate many existing ones and generate predictions that can be verified empirically.​
​
## Introduction

​The model presented here consists of multiple types of graphs that are combined into an evolution graph. Mutation graphs represent valid changes from one genotype to another based on the underlying mutations. Fitness graphs show the fitness of these genotypes, with edges pointing towards fitter vertices. In both of these graphs the vertices are genotypes and the edges represent relationships. However, they can each be changed such that vertices are generations of a population with edges representing the changes from generation to generation. This creates a generation graph from a mutation graph that represents genetic drift (addition of genotypes by mutation), and a selection graph from the fitness graph that represents selection (removal of genotypes due to being outcompeted by fitter genotypes) . Combining the generation and selection graph creates an evolution graph that shows how generations will change based on its genotypes’ underlying mutations and fitness.​
​
​Given a specific number of genotypes it is possible to generate all its possible mutation and fitness graphs and the resulting evolution graphs. This shows patterns among the evolution graphs and makes it possible to consider the specific fitness graphs, for example ones that show epistasis, where genes interact with one another.​

## Usage

To use the EvolutionGraphs package, simply run `Get["~/git/EvolutionGraphs/init.m"]` (be sure adjust this path to match the directory in which you checked out the Git repository).

## Examples

We're going to flesh this out soon, but for now, here is a single example:

<img src="/Images/FirstExample.png" width="442">
